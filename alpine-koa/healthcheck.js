import http from 'http';

const options = {
  host: 'localhost',
  port: process.env.PORT || 8080,
  timeout: 2000,
};
const request = http.request(options, (res) => {
  console.log(`STATUS: ${res.statusCode}`);
  if (res.statusCode === 200) {
    process.exit(0);
  } else {
    process.exit(1);
  }
});
request.on('error', function (error) {
  console.log(`ERROR: ${error}`);
  process.exit(1);
});
request.end();
