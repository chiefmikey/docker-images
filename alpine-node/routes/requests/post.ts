import Router from '@koa/router';

import { saveUser, savePost } from '../../db/queries/save.js';

const router = new Router({ prefix: '/post' });

router.post('/user', async (context) => {
  try {
    const results = await saveUser(context.request.query.something);
    context.response.status = 200;
    context.response.body = results;
  } catch (error) {
    console.error('error with post', error);
    context.response.status = 200;
  }
});

router.post('/post', async (context) => {
  try {
    const results = await savePost(context.request.query.something);
    context.response.status = 200;
    context.response.body = results;
  } catch (error) {
    console.error('error with post', error);
    context.response.status = 200;
  }
});

export default router;
