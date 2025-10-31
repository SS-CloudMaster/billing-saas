import React from 'react';
import App from './App';
import './App.css';

const App: React.FC = () => {
  return (
    <div className="app">
      <header className="app-header">
        <h1>💼 Billing & Accounting SaaS</h1>
        <p>Production-grade billing software for Indian businesses</p>
      </header>

      <main className="app-main">
        <section className="features">
          <h2>✨ Features</h2>
          <ul>
            <li>✅ GST & Non-GST Invoicing</li>
            <li>✅ Expense Tracking with OCR</li>
            <li>✅ Professional Reports & Analytics</li>
            <li>✅ Multi-Tenant Support</li>
            <li>✅ Payment Gateway Integration</li>
            <li>✅ E-Invoicing & Compliance</li>
          </ul>
        </section>

        <section className="status">
          <h2>🚀 Status</h2>
          <p>✅ Application is running successfully!</p>
          <p>
            API Endpoint: <code>/api/health</code>
          </p>
          <p>Built with React, Node.js, and PostgreSQL</p>
        </section>
      </main>
    </div>
  );
};

export default App;