const aws = require('aws-sdk');

exports.handler = async (event) => {

  console.log(event);
  console.log(process.version);

  return {
    statusCode: 200,
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Headers': '*',
    },
    body: JSON.stringify({
      foo: 'bar'
    }),
  };
};
