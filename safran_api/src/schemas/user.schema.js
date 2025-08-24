const { z } = require('zod');
const { emailSchema, usernameSchema, passwordSchema } = require('./common.schema');

const userCreateBody = z.object({
  email: emailSchema,
  username: usernameSchema,
  password: passwordSchema
}).strict();

const userUpdateBody = z.object({
  email: emailSchema.optional(),
  username: usernameSchema.optional(),
  password: passwordSchema.optional()
})
.strict()
.refine(d => Object.keys(d).length > 0, { message: 'At least one field must be provided' });

module.exports = { userCreateBody, userUpdateBody };
