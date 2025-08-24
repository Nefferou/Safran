const { z } = require('zod');
const { emailSchema, usernameSchema, passwordSchema } = require('./common.schema');

const registerBody = z.object({
  email: emailSchema,
  username: usernameSchema,
  password: passwordSchema
}).strict();

const loginBody = z.object({
  email: emailSchema,
  password: z.string().min(1)
}).strict();

module.exports = { registerBody, loginBody };
