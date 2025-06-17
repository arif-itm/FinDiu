import React from 'react';
import { Eye, EyeOff, Plus, TrendingUp, TrendingDown, ArrowUpRight, ArrowDownLeft } from 'lucide-react';
import { Screen } from '../types';
import { mockTransactions } from '../data/mockData';
import { BottomNavigation } from './BottomNavigation';

interface DashboardScreenProps {
  onNavigate: (screen: Screen) => void;
}

export const DashboardScreen: React.FC<DashboardScreenProps> = ({ onNavigate }) => {
  const [showBalance, setShowBalance] = React.useState(true);
  const balance = 12750;
  const monthlyBudget = 8000;
  const spent = 4500;

  return (
    <div className="min-h-screen bg-gray-50 pb-20">
      {/* Header */}
      <div className="bg-gradient-to-r from-primary-500 to-accent-500 px-6 py-8 text-white">
        <div className="flex justify-between items-start mb-6">
          <div>
            <h1 className="text-2xl font-bold">Good morning,</h1>
            <p className="text-lg opacity-90">Arif 👋</p>
          </div>
          <button
            onClick={() => onNavigate('profile')}
            className="w-10 h-10 bg-white/20 rounded-full flex items-center justify-center backdrop-blur-sm hover:bg-white/30 transition-colors cursor-pointer"
          >
            <span className="text-lg font-semibold">A</span>
          </button>
        </div>

        {/* Balance Card */}
        <div className="bg-white/10 backdrop-blur-sm rounded-3xl p-6">
          <div className="flex justify-between items-center mb-2">
            <span className="text-sm opacity-80">Total Balance</span>
            <button
              onClick={() => setShowBalance(!showBalance)}
              className="p-1 hover:bg-white/10 rounded-lg transition-colors"
            >
              {showBalance ? <Eye className="w-4 h-4" /> : <EyeOff className="w-4 h-4" />}
            </button>
          </div>
          <div className="text-3xl font-bold mb-4">
            {showBalance ? `৳${balance.toLocaleString()}` : '৳••••••'}
          </div>
          <div className="flex space-x-4">
            <div className="flex-1 bg-white/10 rounded-2xl p-3 text-center">
              <ArrowUpRight className="w-5 h-5 mx-auto mb-1" />
              <div className="text-sm opacity-80">Income</div>
              <div className="font-semibold">৳2,500</div>
            </div>
            <div className="flex-1 bg-white/10 rounded-2xl p-3 text-center">
              <ArrowDownLeft className="w-5 h-5 mx-auto mb-1" />
              <div className="text-sm opacity-80">Expenses</div>
              <div className="font-semibold">৳1,820</div>
            </div>
          </div>
        </div>
      </div>

      {/* Quick Actions */}
      <div className="px-6 -mt-6 mb-6">
        <div className="bg-white rounded-3xl p-6 shadow-sm">
          <h2 className="text-lg font-semibold mb-4 text-gray-900">Quick Actions</h2>
          <div className="grid grid-cols-2 gap-4">
            <button
              onClick={() => onNavigate('add-expense')}
              className="flex items-center space-x-3 p-4 bg-primary-50 rounded-2xl hover:bg-primary-100 transition-colors"
            >
              <div className="w-10 h-10 bg-primary-500 rounded-xl flex items-center justify-center">
                <Plus className="w-5 h-5 text-white" />
              </div>
              <div className="text-left">
                <div className="font-semibold text-gray-900">Add Expense</div>
                <div className="text-sm text-gray-600">Track spending</div>
              </div>
            </button>
            <button
              onClick={() => onNavigate('savings')}
              className="flex items-center space-x-3 p-4 bg-secondary-50 rounded-2xl hover:bg-secondary-100 transition-colors"
            >
              <div className="w-10 h-10 bg-secondary-500 rounded-xl flex items-center justify-center">
                <TrendingUp className="w-5 h-5 text-white" />
              </div>
              <div className="text-left">
                <div className="font-semibold text-gray-900">Save Money</div>
                <div className="text-sm text-gray-600">Set goals</div>
              </div>
            </button>
          </div>
        </div>
      </div>

      {/* Budget Overview */}
      <div className="px-6 mb-6">
        <div className="bg-white rounded-3xl p-6 shadow-sm">
          <div className="flex justify-between items-center mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Monthly Budget</h2>
            <span className="text-sm text-gray-600">Jan 2024</span>
          </div>
          <div className="mb-4">
            <div className="flex justify-between text-sm mb-2">
              <span className="text-gray-600">Spent</span>
              <span className="font-semibold">৳{spent.toLocaleString()} of ৳{monthlyBudget.toLocaleString()}</span>
            </div>
            <div className="w-full bg-gray-200 rounded-full h-3">
              <div
                className="bg-gradient-to-r from-primary-500 to-accent-500 h-3 rounded-full transition-all duration-300"
                style={{ width: `${(spent / monthlyBudget) * 100}%` }}
              ></div>
            </div>
          </div>
          <div className="text-sm text-gray-600">
            You have ৳{(monthlyBudget - spent).toLocaleString()} left to spend this month
          </div>
        </div>
      </div>

      {/* Recent Transactions */}
      <div className="px-6 mb-6">
        <div className="bg-white rounded-3xl p-6 shadow-sm">
          <div className="flex justify-between items-center mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Recent Transactions</h2>
            <button 
              onClick={() => onNavigate('transactions')}
              className="text-primary-600 text-sm font-medium hover:text-primary-700 transition-colors"
            >
              See All
            </button>
          </div>
          <div className="space-y-4">
            {mockTransactions.slice(0, 4).map((transaction) => (
              <div key={transaction.id} className="flex items-center space-x-4">
                <div className={`w-12 h-12 rounded-2xl flex items-center justify-center ${
                  transaction.type === 'income' ? 'bg-secondary-100' : 'bg-red-100'
                }`}>
                  {transaction.type === 'income' ? (
                    <TrendingUp className="w-6 h-6 text-secondary-600" />
                  ) : (
                    <TrendingDown className="w-6 h-6 text-red-600" />
                  )}
                </div>
                <div className="flex-1">
                  <div className="font-semibold text-gray-900">{transaction.description}</div>
                  <div className="text-sm text-gray-600">{transaction.category}</div>
                </div>
                <div className={`font-semibold ${
                  transaction.type === 'income' ? 'text-secondary-600' : 'text-red-600'
                }`}>
                  {transaction.type === 'income' ? '+' : ''}৳{Math.abs(transaction.amount).toLocaleString()}
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      <BottomNavigation currentScreen="dashboard" onNavigate={onNavigate} />
    </div>
  );
};