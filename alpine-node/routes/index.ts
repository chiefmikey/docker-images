import Router from '@koa/router';

import getRouter from './requests/get';
import postRouter from './requests/post';

const router = new Router({ prefix: '/submit' });

router.use(
  postRouter.routes(),
  postRouter.allowedMethods(),
  getRouter.routes(),
  getRouter.allowedMethods(),
);

export default router;
