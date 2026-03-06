import React from 'react';

export default function Roadmap() {
    return (
        <div className="bg-white p-6 rounded-xl shadow-sm border border-gray-100">
            <h2 className="text-xl font-bold mb-4 text-gray-800">Smart Sprint Study Map</h2>
            <div className="space-y-4">
                <div className="p-4 border border-blue-100 bg-blue-50 rounded-lg">
                    <h3 className="font-semibold text-blue-800">Sprint 1: Algorithms</h3>
                    <p className="text-sm text-blue-600 mt-1">Weightage: 15% | Progress: 50%</p>
                </div>
                <div className="p-4 border border-gray-200 rounded-lg text-gray-500">
                    <h3 className="font-semibold">Sprint 2: Data Structures</h3>
                    <p className="text-sm mt-1">Weightage: 20% | Locked</p>
                </div>
            </div>
        </div>
    );
}
