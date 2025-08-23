const { z } = require('zod');

const passwordSchema = z
  .string()
  .min(12, 'Password must be at least 12 characters')
  .regex(/[a-z]/, 'Password must contain a lowercase letter')
  .regex(/[A-Z]/, 'Password must contain an uppercase letter')
  .regex(/[^A-Za-z0-9]/, 'Password must contain a special character');

const emailSchema = z.string().email();
const usernameSchema = z.string().min(3).max(32);

// Params
const idParamSchema = z.object({ id: z.coerce.number().int().positive() });
const emailParamSchema = z.object({ email: emailSchema });

module.exports = {
  passwordSchema,
  emailSchema,
  usernameSchema,
  idParamSchema,
  emailParamSchema
};
