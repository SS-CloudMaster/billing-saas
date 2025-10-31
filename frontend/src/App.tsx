cat > frontend/src/App.tsx << 'EOF'
import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';

function App() {
  return (
    <Router>
      <div className="app">
        <h1>💼 Billing & Accounting SaaS</h1>
        <p>Welcome to your billing software</p>
        <Routes>
          <Route path="/" element={<div>Home Page</div>} />
          <Route path="/invoices" element={<div>Invoices Page</div>} />
          <Route path="/expenses" element={<div>Expenses Page</div>} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;
EOF
