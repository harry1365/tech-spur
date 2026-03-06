import React, { useEffect, useRef, useState } from 'react';
import mermaid from 'mermaid';

mermaid.initialize({ startOnLoad: true, theme: 'default' });

export default function Debugger() {
    const [diagramCode, setDiagramCode] = useState(`graph TD;\nA-->B;`);
    const diagramRef = useRef(null);

    useEffect(() => {
        if (diagramRef.current) {
            mermaid.contentLoaded();
        }
    }, [diagramCode]);

    return (
        <div className="bg-white p-6 rounded-xl shadow-sm border border-gray-100 h-full">
            <h2 className="text-xl font-bold mb-4 text-gray-800">Visual Logic Engine</h2>
            <div className="mb-4">
                <textarea
                    className="w-full p-3 border rounded-lg text-sm font-mono text-gray-700 bg-gray-50 mb-2 focus:ring-2 focus:ring-blue-500 outline-none"
                    rows="4"
                    value={diagramCode}
                    onChange={(e) => setDiagramCode(e.target.value)}
                />
                <button className="px-4 py-2 bg-blue-600 text-white font-medium rounded-lg hover:bg-blue-700 transition w-full">
                    Generate Visual
                </button>
            </div>
            <div className="border border-gray-200 rounded-lg p-4 flex justify-center items-center min-h-[300px] bg-white">
                <div className="mermaid" ref={diagramRef}>
                    {diagramCode}
                </div>
            </div>
        </div>
    );
}
