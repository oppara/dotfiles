#!/usr/bin/env -S deno run --allow-run=git
// Claude Code statusline script (Deno)
// git実行のみ許可（このdotfilesはNixを使わないため --allow-run=git で十分）

const ICON = {
  robo: "\u{F06A9}",
  folder: "\u{F4D3}",
  folderChanged: "\u{F0252}",
  gitBranch: "\u{E725}",
  battery: [
    // index 0 = lowest, 9 = highest
    "\u{F008E}", // 0-14%
    "\u{F007A}", // 15-24%
    "\u{F007B}", // 25-34%
    "\u{F007C}", // 35-44%
    "\u{F007D}", // 45-54%
    "\u{F007F}", // 55-64%
    "\u{F0080}", // 65-74%
    "\u{F0081}", // 75-84%
    "\u{F0082}", // 85-94%
    "\u{F0083}", // 95-100%
  ],
} as const;

const COLOR = {
  red: "\x1b[31m",
  yellow: "\x1b[33m",
  green: "\x1b[32m",
  reset: "\x1b[0m",
} as const;

function colorByPct(pct: number): string {
  if (pct >= 90) return COLOR.red;
  if (pct >= 70) return COLOR.yellow;
  return COLOR.green;
}

function symbolByPct(pct: number): string {
  const idx = pct >= 95 ? 9 : Math.max(0, Math.floor(pct / 10));
  return ICON.battery[idx];
}

function formatDuration(ms: number): string {
  const totalMin = Math.floor(ms / 60000);
  const h = Math.floor(totalMin / 60);
  const m = totalMin % 60;
  return h > 0 ? `${h}h${m}m` : `${m}m`;
}

function formatRemaining(resetAt: number | null): string {
  if (resetAt == null) return "-";
  const remaining = resetAt - Math.floor(Date.now() / 1000);
  if (remaining <= 0) return "0";
  if (remaining < 3600) return `${Math.floor(remaining / 60)}m`;
  if (remaining < 86400) return `${Math.floor(remaining / 3600)}h`;
  return `${Math.floor(remaining / 86400)}d`;
}

async function getGitBranch(cwd?: string): Promise<string> {
  const opts = { stderr: "null" as const, stdout: "null" as const, ...(cwd && { cwd }) };
  try {
    const { success } = await new Deno.Command("git", {
      ...opts,
      args: ["rev-parse", "--git-dir"],
    }).output();
    if (!success) return "";

    const pipeOpts = { ...opts, stdout: "piped" as const };

    const branch = new TextDecoder().decode(
      (await new Deno.Command("git", { ...pipeOpts, args: ["branch", "--show-current"] }).output()).stdout,
    ).trim();
    if (branch) return ` | ${ICON.gitBranch} ${branch}`;

    const hash = new TextDecoder().decode(
      (await new Deno.Command("git", { ...pipeOpts, args: ["rev-parse", "--short", "HEAD"] }).output()).stdout,
    ).trim();
    if (hash) return ` | ${ICON.gitBranch} HEAD (${hash})`;
  } catch {
    // not a git repo
  }
  return "";
}

const buf = new Uint8Array(1024 * 64);
const n = await Deno.stdin.read(buf);
const input = JSON.parse(new TextDecoder().decode(buf.subarray(0, n ?? 0)));

const model = (input.model?.display_name ?? "").replace(
  /\s*\(1M context\)/,
  " 1M",
);
const effort = input.effort?.level ?? "";
const modelDisplay = effort ? `${model} ${effort}` : model;
const currentDir = input.workspace?.current_dir ?? "";
const projectDir = input.workspace?.project_dir ?? "";
const ctxPct = Math.floor(input.context_window?.used_percentage ?? 0);
const fivePct = Math.floor(input.rate_limits?.five_hour?.used_percentage ?? 0);
const weekPct = Math.floor(input.rate_limits?.seven_day?.used_percentage ?? 0);
const weekReset = input.rate_limits?.seven_day?.resets_at ?? null;

const dirName = currentDir.split("/").pop() ?? "";
const dirSymbol = currentDir !== projectDir ? ICON.folderChanged : ICON.folder;

const gitBranch = await getGitBranch(currentDir || undefined);
const weekResetDisplay = formatRemaining(weekReset);
const costUsd = input.cost?.total_cost_usd ?? 0;
const durationDisplay = formatDuration(input.cost?.total_duration_ms ?? 0);

const R = COLOR.reset;
const segments = [
  // モデル名（reasoning effortがあれば併記）
  `${ICON.robo} ${modelDisplay}`,

  // カレントディレクトリ名 + gitブランチ（project_dirと異なる場合はフォルダアイコンが変化）
  `${dirSymbol} ${dirName}${gitBranch}`,

  // コンテキストウィンドウ使用率
  `ctx ${colorByPct(ctxPct)}${symbolByPct(ctxPct)} ${ctxPct}%${R}`,

  // 直近5時間のレート制限使用率
  `5h ${colorByPct(fivePct)}${symbolByPct(fivePct)} ${fivePct}%${R}`,

  // 週次（7日間）のレート制限使用率 + リセットまでの残り時間
  `7d ${colorByPct(weekPct)}${symbolByPct(weekPct)} ${weekPct}%${R} (~${weekResetDisplay})`,

  // セッション累計コスト（USD） / 処理時間（放置時間を含まないAPI処理時間の累計）
  `$${costUsd.toFixed(2)} / ${durationDisplay}`,
];

// gitブランチ名の後ろで改行し、残りのセグメントは2行目に表示する
console.log(segments.slice(0, 2).join(" | "));
console.log(segments.slice(2).join(" | "));

// フッター（mode切り替え表示）との間に余白を作るため見た目上は空行の3行目を追加する
// (空白のみの行はharness側でトリムされ非表示になるため、ゼロ幅スペースを使う)
console.log("​");
