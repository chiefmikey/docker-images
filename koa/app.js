import Koa from 'koa';
import bodyParser from 'koa-bodyparser';
import cors from '@koa/cors';
import serve from 'koa-static';
import path from 'path';
import index from './routes/index.js';

const __dirname = import.meta.url.slice(7, import.meta.url.lastIndexOf('/'));

const port = process.env.PORT || 8080;

const app = new Koa();

app
  .use(
    cors({
      origin: '*',
      methods: 'GET, POST',
      allowedHeaders: '*',
      exposedHeaders: '*',
    }),
  )
  .use(bodyParser())
  .use(serve(path.join(__dirname, '/client/public')))
  .use(index.routes())
  .use(index.allowedMethods());

app.listen(port, () =>
  console.log('Koa is listening on port', port),
);

export default app;
