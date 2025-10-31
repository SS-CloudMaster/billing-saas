cat > backend/src/server.ts << 'EOF'
import express, { Request, Response } from 'express';
import cors from 'cors';
import helmet from 'helmet';
import dotenv from 'dotenv';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(helmet());
app.use(cors({ origin: process.env.CORS_ORIGIN }));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Routes
app.get('/api/health', (req: Request, res: Response) => {
  res.json({ 
    status: 'OK', 
    timestamp: new Date(),
    uptime: process.uptime()
  });
});

app.post('/api/auth/login', (req: Request, res: Response) => {
  res.json({ 
    token: 'sample-jwt-token', 
    user: { id: 1, email: 'user@example.com' } 
  });
});

app.get('/api/invoices', (req: Request, res: Response) => {
  res.json({ invoices: [] });
});

app.get('/', (req: Request, res: Response) => {
  res.json({ message: 'Billing SaaS API is running' });
});

// Error handling
app.use((err: any, req: Request, res: Response) => {
  console.error(err);
  res.status(500).json({ error: 'Internal Server Error' });
});

app.listen(PORT, () => {
  console.log(`✅ Server running on http://localhost:${PORT}`);
});

export default app;
EOF
