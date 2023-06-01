from logging import basicConfig, getLogger, DEBUG

# これはメインのファイルにのみ書く
basicConfig(level=DEBUG)

# これはすべてのファイルに書く
logger = getLogger(__name__)

logger.debug('hello')
