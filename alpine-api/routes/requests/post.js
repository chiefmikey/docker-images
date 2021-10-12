/* eslint-disable no-param-reassign */
import Router from '@koa/router';
import { saveUser, savePost } from '../../db/queries/save.js';

const router = new Router({ prefix: '/post' });

router.post('/user', async (ctx) => {
  try {
    const results = await saveUser(ctx.request.query.something);
    ctx.response.status = 200;
    ctx.response.body = results;
  } catch (error) {
    console.error('error with post', error);
    ctx.response.status = 200;
  }
});

router.post('/post', async (ctx) => {
  try {
    const results = await savePost(ctx.request.query.something);
    ctx.response.status = 200;
    ctx.response.body = results;
  } catch (error) {
    console.error('error with post', error);
    ctx.response.status = 200;
  }
});

export default router;
