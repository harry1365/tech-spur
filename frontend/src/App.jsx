import React from 'react';
import Roadmap from './components/Roadmap';
import Debugger from './components/Debugger';
import Vault from './components/Vault';

function App() {
    return (
        <div className="min-h-screen p-8 max-w-7xl mx-auto space-y-8">
            <header className="text-center py-6 border-b border-gray-200">
                <h1 className="text-4xl font-extrabold tracking-tight text-blue-600">Architect-AI</h1>
                <p className="mt-2 text-lg text-gray-600">Curriculum-Locked Study Engine</p>
            </header>

            <main className="grid grid-cols-1 md:grid-cols-2 gap-8">
                <div className="space-y-8">
                    <Roadmap />
                    <Vault />
                </div>
                <div>
                    <Debugger />
                </div>
            </main>
        </div>
    );
}

export default App;
