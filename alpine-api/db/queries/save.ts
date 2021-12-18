import { User, Post } from '../index.js';

export const saveUser = async (input1, input2, input3) => {
  try {
    const result = await new User({
      input1,
      input2,
      input3,
    });
    await result.save();
    return 'Saved';
  } catch (error) {
    console.error(error);
    return error;
  }
};

export const savePost = async (input1, input2, input3) => {
  try {
    const result = await new Post({
      input1,
      input2,
      input3,
    });
    await result.save();
    return 'Saved';
  } catch (error) {
    console.error(error);
    return error;
  }
};
