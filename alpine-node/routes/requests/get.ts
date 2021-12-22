import Router from '@koa/router';

import { findUser, findPost } from '../../db/queries/find.js';
import process from '../helpers/process.js';

const router = new Router({ prefix: '/get' });

router.get('/user', async (context) => {
  try {
    const shape = process(context.request.query.something);
    const results = await findUser(shape);
    context.response.status = 200;
    context.response.body = results;
  } catch (error) {
    console.error('error with get', error);
    context.response.status = 200;
  }
});

router.get('/post', async (context) => {
  try {
    const shape = process(context.request.query.something);
    const results = await findPost(shape);
    context.response.status = 200;
    context.response.body = results;
  } catch (error) {
    console.error('error with get', error);
    context.response.status = 200;
  }
});

export default router;
