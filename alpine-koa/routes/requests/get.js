/* eslint-disable no-param-reassign */
import Router from '@koa/router';
import process from '../helpers/process.js';

const router = new Router({ prefix: '/get' });

router.get('/', async (ctx) => {
  try {
    const results = await process(ctx.request.query.something);
    ctx.response.status = 200;
    ctx.response.body = results;
  } catch (error) {
    console.error('error with get', error);
    ctx.response.status = 200;
  }
});

export default router;
