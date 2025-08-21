const swaggerJsdoc = require('swagger-jsdoc');

const options = {
    definition: {
        openapi: '3.0.3',
        info: {
            title: 'Safran API',
            version: '0.1.0',
            description: 'API Express (Users + Auth) et métriques Prometheus.'
        },
        servers: [
            { url: 'http://localhost:3000', description: 'HTTP local' },
        ],
        components: {
            securitySchemes: {
                BearerAuth: {
                    type: 'http',
                    scheme: 'bearer',
                    bearerFormat: 'JWT'
                }
            },
            schemas: {
                User: {
                    type: 'object',
                    properties: {
                        id: { type: 'integer', example: 1 },
                        email: { type: 'string', format: 'email', example: 'alice@example.com' },
                        username: { type: 'string', example: 'alice' },
                    },
                    required: ['id','email','username']
                },
                UserCreate: {
                    type: 'object',
                    properties: {
                        email: { type: 'string', format: 'email' },
                        username: { type: 'string', minLength: 3, maxLength: 32 },
                        password: {
                            type: 'string',
                            description: '≥8, 1 minuscule, 1 majuscule, 1 chiffre, 1 spécial',
                            minLength: 8,
                            pattern: '^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^A-Za-z0-9]).{8,}$'
                        },
                    },
                    required: ['email','username']
                },
                UserUpdate: {
                    type: 'object',
                    properties: {
                        email: { type: 'string', format: 'email' },
                        username: { type: 'string', minLength: 3, maxLength: 32 },
                        password: {
                            type: 'string',
                            minLength: 8,
                            pattern: '^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^A-Za-z0-9]).{8,}$'
                        },
                    },
                    additionalProperties: false
                },
                AuthRegisterRequest: {
                    type: 'object',
                    properties: {
                        email: { type: 'string', format: 'email' },
                        username: { type: 'string', minLength: 3, maxLength: 32 },
                        password: {
                            type: 'string',
                            minLength: 8,
                            pattern: '^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^A-Za-z0-9]).{8,}$'
                        }
                    },
                    required: ['email','username','password']
                },
                LoginRequest: {
                    type: 'object',
                    properties: {
                        email: { type: 'string', format: 'email' },
                        password: { type: 'string', minLength: 1 }
                    },
                    required: ['email','password']
                },
                AuthResponse: {
                    type: 'object',
                    properties: {
                        id: { type: 'integer', example: 1 },
                        email: { type: 'string', format: 'email', example: 'alice@example.com' },
                        username: { type: 'string', example: 'alice' },
                        token: { type: 'string', description: 'JWT' }
                    }
                },
                EnvelopeData: {
                    type: 'object',
                    properties: { data: {} },
                    description: 'Enveloppe de réponse standard'
                },
                ErrorResponse: {
                    type: 'object',
                    properties: {
                        error: {
                            type: 'object',
                            properties: {
                                type: { type: 'string', example: 'validation_error' },
                                message: { type: 'string' },
                                details: { type: 'array', items: { type: 'object' } }
                            }
                        }
                    }
                }
            }
        },
        tags: [
            { name: 'Auth', description: 'Authentification & identité' },
            { name: 'Users', description: 'Gestion des utilisateurs' },
        ]
    },
    apis: ['src/routes/**/*.js']
};

const swaggerSpec = swaggerJsdoc(options);
module.exports = { swaggerSpec };
