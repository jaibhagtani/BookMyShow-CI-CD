// packages/db/src/client.ts (or wherever your db client lives)
import 'dotenv/config';
import { PrismaClient } from '@prisma/client';

console.log('DATABASE_URL:', process.env.DATABASE_URL?.slice(0, 60) ?? '(not set)');

export const client = new PrismaClient();
