import React from 'react';
import { ArrowLeft, TrendingUp, TrendingDown, PieChart, BarChart3 } from 'lucide-react';
import { Screen } from '../types';

interface AnalyticsScreenProps {
  onNavigate: (screen: Screen) => void;
}

export const AnalyticsScreen: React.FC<AnalyticsScreenProps> = ({ onNavigate }) => {
  const spendingData = [
    { category: 'Food', amount: 2800, percentage: 35, color: 'bg-orange-500' },
    { category: 'Transport', amount: 1500, percentage: 19, color: 'bg-blue-500' },
    { category: 'Education', amount: 1200, percentage: 15, color: 'bg-purple-500' },
    { category: 'Entertainment', amount: 1000, percentage: 12, color: 'bg-pink-500' },
    { category: 'Shopping', amount: 800, percentage: 10, color: 'bg-green-500' },
    { category: 'Others', amount: 700, percentage: 9, color: 'bg-gray-500' },
  ];

  const monthlyTrend = [
    { month: 'Oct', amount: 6800 },
    { month: 'Nov', amount: 7200 },
    { month: 'Dec', amount: 6900 },
    { month: 'Jan', amount: 8000 },
  ];

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <div className="bg-gradient-to-r from-primary-500 to-secondary-500 px-6 py-4 text-white">
        <div className="flex items-center space-x-4 mb-6">
          <button
            onClick={() => onNavigate('dashboard')}
            className="w-10 h-10 bg-white/20 rounded-2xl flex items-center justify-center hover:bg-white/30 transition-colors backdrop-blur-sm"
          >
            <ArrowLeft className="w-5 h-5" />
          </button>
          <h1 className="text-xl font-bold">Analytics</h1>
        </div>

        {/* Summary Cards */}
        <div className="grid grid-cols-2 gap-4">
          <div className="bg-white/10 backdrop-blur-sm rounded-2xl p-4">
            <div className="flex items-center space-x-2 mb-2">
              <TrendingUp className="w-5 h-5" />
              <span className="text-sm opacity-80">This Month</span>
            </div>
            <div className="text-2xl font-bold">৳8,000</div>
            <div className="text-sm opacity-80">+12% from last month</div>
          </div>
          <div className="bg-white/10 backdrop-blur-sm rounded-2xl p-4">
            <div className="flex items-center space-x-2 mb-2">
              <TrendingDown className="w-5 h-5" />
              <span className="text-sm opacity-80">Daily Average</span>
            </div>
            <div className="text-2xl font-bold">৳258</div>
            <div className="text-sm opacity-80">-5% from last month</div>
          </div>
        </div>
      </div>

      <div className="px-6 -mt-6 pb-6 space-y-6">
        {/* Spending by Category */}
        <div className="bg-white rounded-3xl p-6 shadow-sm">
          <div className="flex items-center space-x-3 mb-6">
            <PieChart className="w-6 h-6 text-primary-500" />
            <h2 className="text-lg font-semibold text-gray-900">Spending by Category</h2>
          </div>

          <div className="space-y-4">
            {spendingData.map((item) => (
              <div key={item.category}>
                <div className="flex justify-between items-center mb-2">
                  <div className="flex items-center space-x-3">
                    <div className={`w-4 h-4 ${item.color} rounded-full`}></div>
                    <span className="font-medium text-gray-900">{item.category}</span>
                  </div>
                  <div className="text-right">
                    <div className="font-semibold text-gray-900">৳{item.amount.toLocaleString()}</div>
                    <div className="text-sm text-gray-600">{item.percentage}%</div>
                  </div>
                </div>
                <div className="w-full bg-gray-200 rounded-full h-2">
                  <div
                    className={`h-2 rounded-full ${item.color}`}
                    style={{ width: `${item.percentage}%` }}
                  ></div>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Monthly Trend */}
        <div className="bg-white rounded-3xl p-6 shadow-sm">
          <div className="flex items-center space-x-3 mb-6">
            <BarChart3 className="w-6 h-6 text-primary-500" />
            <h2 className="text-lg font-semibold text-gray-900">Monthly Spending Trend</h2>
          </div>

          <div className="space-y-4">
            {monthlyTrend.map((item, index) => {
              const maxAmount = Math.max(...monthlyTrend.map(d => d.amount));
              const percentage = (item.amount / maxAmount) * 100;
              const isIncrease = index > 0 && item.amount > monthlyTrend[index - 1].amount;

              return (
                <div key={item.month}>
                  <div className="flex justify-between items-center mb-2">
                    <span className="font-medium text-gray-900">{item.month} 2024</span>
                    <div className="flex items-center space-x-2">
                      <span className="font-semibold text-gray-900">৳{item.amount.toLocaleString()}</span>
                      {index > 0 && (
                        <div className={`flex items-center ${isIncrease ? 'text-red-600' : 'text-secondary-600'}`}>
                          {isIncrease ? (
                            <TrendingUp className="w-4 h-4" />
                          ) : (
                            <TrendingDown className="w-4 h-4" />
                          )}
                        </div>
                      )}
                    </div>
                  </div>
                  <div className="w-full bg-gray-200 rounded-full h-3">
                    <div
                      className="h-3 rounded-full bg-gradient-to-r from-primary-500 to-secondary-500"
                      style={{ width: `${percentage}%` }}
                    ></div>
                  </div>
                </div>
              );
            })}
          </div>
        </div>

        {/* Insights */}
        <div className="bg-white rounded-3xl p-6 shadow-sm">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">Insights</h2>
          <div className="space-y-4">
            <div className="flex items-start space-x-3 p-4 bg-blue-50 rounded-2xl">
              <div className="w-8 h-8 bg-blue-500 rounded-2xl flex items-center justify-center flex-shrink-0">
                <TrendingUp className="w-4 h-4 text-white" />
              </div>
              <div>
                <h3 className="font-semibold text-gray-900 mb-1">Food spending increased</h3>
                <p className="text-sm text-gray-600">You spent 15% more on food this month. Consider meal planning to reduce costs.</p>
              </div>
            </div>
            <div className="flex items-start space-x-3 p-4 bg-green-50 rounded-2xl">
              <div className="w-8 h-8 bg-secondary-500 rounded-2xl flex items-center justify-center flex-shrink-0">
                <TrendingDown className="w-4 h-4 text-white" />
              </div>
              <div>
                <h3 className="font-semibold text-gray-900 mb-1">Great job on transport!</h3>
                <p className="text-sm text-gray-600">You saved ৳300 on transport this month by using your student bus pass.</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};