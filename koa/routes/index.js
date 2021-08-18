import Router from '@koa/router';
import postRouter from './requests/post.js';
import getRouter from './requests/get.js';

const router = new Router({ prefix: '/submit' });

router.use(
  postRouter.routes(),
  postRouter.allowedMethods(),
  getRouter.routes(),
  getRouter.allowedMethods(),
);

export default router;
