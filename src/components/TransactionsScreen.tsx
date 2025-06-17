import React, { useState } from 'react';
import { ArrowLeft, Search, Filter, TrendingUp, TrendingDown, Calendar, ArrowUpRight, ArrowDownLeft } from 'lucide-react';
import { Screen } from '../types';
import { mockTransactions } from '../data/mockData';

interface TransactionsScreenProps {
  onNavigate: (screen: Screen) => void;
}

export const TransactionsScreen: React.FC<TransactionsScreenProps> = ({ onNavigate }) => {
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedFilter, setSelectedFilter] = useState('all');
  const [selectedMonth, setSelectedMonth] = useState('current');

  const filters = [
    { id: 'all', label: 'All', count: mockTransactions.length },
    { id: 'income', label: 'Income', count: mockTransactions.filter(t => t.type === 'income').length },
    { id: 'expense', label: 'Expenses', count: mockTransactions.filter(t => t.type === 'expense').length },
  ];

  const months = [
    { id: 'current', label: 'This Month' },
    { id: 'last', label: 'Last Month' },
    { id: 'all', label: 'All Time' },
  ];

  const filteredTransactions = mockTransactions.filter(transaction => {
    const matchesSearch = transaction.description.toLowerCase().includes(searchQuery.toLowerCase()) ||
                         transaction.category.toLowerCase().includes(searchQuery.toLowerCase());
    const matchesFilter = selectedFilter === 'all' || transaction.type === selectedFilter;
    return matchesSearch && matchesFilter;
  });

  const totalIncome = filteredTransactions
    .filter(t => t.type === 'income')
    .reduce((sum, t) => sum + Math.abs(t.amount), 0);

  const totalExpenses = filteredTransactions
    .filter(t => t.type === 'expense')
    .reduce((sum, t) => sum + Math.abs(t.amount), 0);

  const getTransactionIcon = (transaction: any) => {
    if (transaction.type === 'income') {
      return <TrendingUp className="w-6 h-6 text-secondary-600" />;
    } else {
      return <TrendingDown className="w-6 h-6 text-red-600" />;
    }
  };

  const formatDate = (dateString: string) => {
    const date = new Date(dateString);
    const today = new Date();
    const diffTime = today.getTime() - date.getTime();
    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

    if (diffDays === 0) return 'Today';
    if (diffDays === 1) return 'Yesterday';
    if (diffDays < 7) return `${diffDays} days ago`;
    return date.toLocaleDateString('en-BD', { month: 'short', day: 'numeric' });
  };

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <div className="bg-gradient-to-r from-primary-500 to-accent-500 px-6 py-4 text-white">
        <div className="flex items-center space-x-4 mb-6">
          <button
            onClick={() => onNavigate('dashboard')}
            className="w-10 h-10 bg-white/20 rounded-2xl flex items-center justify-center hover:bg-white/30 transition-colors backdrop-blur-sm"
          >
            <ArrowLeft className="w-5 h-5" />
          </button>
          <h1 className="text-xl font-bold">All Transactions</h1>
        </div>

        {/* Summary Cards */}
        <div className="grid grid-cols-2 gap-4 mb-4">
          <div className="bg-white/10 backdrop-blur-sm rounded-2xl p-4">
            <div className="flex items-center space-x-2 mb-2">
              <ArrowUpRight className="w-5 h-5" />
              <span className="text-sm opacity-80">Total Income</span>
            </div>
            <div className="text-2xl font-bold">৳{totalIncome.toLocaleString()}</div>
          </div>
          <div className="bg-white/10 backdrop-blur-sm rounded-2xl p-4">
            <div className="flex items-center space-x-2 mb-2">
              <ArrowDownLeft className="w-5 h-5" />
              <span className="text-sm opacity-80">Total Expenses</span>
            </div>
            <div className="text-2xl font-bold">৳{totalExpenses.toLocaleString()}</div>
          </div>
        </div>

        {/* Search Bar */}
        <div className="relative">
          <Search className="absolute left-4 top-1/2 transform -translate-y-1/2 w-5 h-5 text-white/60" />
          <input
            type="text"
            placeholder="Search transactions..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            className="w-full pl-12 pr-4 py-3 bg-white/10 backdrop-blur-sm border border-white/20 rounded-2xl text-white placeholder-white/60 focus:bg-white/20 focus:border-white/40 outline-none transition-all"
          />
        </div>
      </div>

      <div className="px-6 -mt-6 pb-6">
        {/* Filters */}
        <div className="bg-white rounded-3xl p-6 shadow-sm mb-6">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Filters</h2>
            <div className="flex items-center space-x-2">
              <Filter className="w-5 h-5 text-gray-400" />
              <select
                value={selectedMonth}
                onChange={(e) => setSelectedMonth(e.target.value)}
                className="text-sm border border-gray-200 rounded-xl px-3 py-1 focus:border-primary-500 outline-none"
              >
                {months.map(month => (
                  <option key={month.id} value={month.id}>{month.label}</option>
                ))}
              </select>
            </div>
          </div>

          <div className="flex space-x-2">
            {filters.map((filter) => (
              <button
                key={filter.id}
                onClick={() => setSelectedFilter(filter.id)}
                className={`flex items-center space-x-2 px-4 py-2 rounded-2xl font-medium text-sm transition-all ${
                  selectedFilter === filter.id
                    ? 'bg-primary-500 text-white'
                    : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
                }`}
              >
                <span>{filter.label}</span>
                <span className={`px-2 py-1 rounded-full text-xs ${
                  selectedFilter === filter.id
                    ? 'bg-white/20 text-white'
                    : 'bg-gray-200 text-gray-600'
                }`}>
                  {filter.count}
                </span>
              </button>
            ))}
          </div>
        </div>

        {/* Transactions List */}
        <div className="bg-white rounded-3xl shadow-sm overflow-hidden">
          <div className="p-6 border-b border-gray-100">
            <h2 className="text-lg font-semibold text-gray-900">
              {filteredTransactions.length} Transaction{filteredTransactions.length !== 1 ? 's' : ''}
            </h2>
          </div>

          <div className="divide-y divide-gray-100">
            {filteredTransactions.map((transaction) => (
              <div key={transaction.id} className="p-6 hover:bg-gray-50 transition-colors">
                <div className="flex items-center space-x-4">
                  <div className={`w-12 h-12 rounded-2xl flex items-center justify-center ${
                    transaction.type === 'income' ? 'bg-secondary-100' : 'bg-red-100'
                  }`}>
                    {getTransactionIcon(transaction)}
                  </div>
                  
                  <div className="flex-1">
                    <div className="flex items-center justify-between mb-1">
                      <h3 className="font-semibold text-gray-900">{transaction.description}</h3>
                      <div className={`font-bold text-lg ${
                        transaction.type === 'income' ? 'text-secondary-600' : 'text-red-600'
                      }`}>
                        {transaction.type === 'income' ? '+' : '-'}৳{Math.abs(transaction.amount).toLocaleString()}
                      </div>
                    </div>
                    
                    <div className="flex items-center justify-between">
                      <div className="flex items-center space-x-3">
                        <span className="text-sm text-gray-600">{transaction.category}</span>
                        <span className="w-1 h-1 bg-gray-300 rounded-full"></span>
                        <span className="text-sm text-gray-600">{formatDate(transaction.date)}</span>
                      </div>
                      
                      <div className="flex items-center space-x-2">
                        <Calendar className="w-4 h-4 text-gray-400" />
                        <span className="text-xs text-gray-500">
                          {new Date(transaction.date).toLocaleDateString('en-BD')}
                        </span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            ))}
          </div>

          {filteredTransactions.length === 0 && (
            <div className="p-12 text-center">
              <div className="w-16 h-16 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <Search className="w-8 h-8 text-gray-400" />
              </div>
              <h3 className="text-lg font-semibold text-gray-900 mb-2">No transactions found</h3>
              <p className="text-gray-600">Try adjusting your search or filter criteria</p>
            </div>
          )}
        </div>

        {/* Monthly Summary */}
        {filteredTransactions.length > 0 && (
          <div className="bg-white rounded-3xl p-6 shadow-sm mt-6">
            <h3 className="text-lg font-semibold text-gray-900 mb-4">Monthly Summary</h3>
            <div className="grid grid-cols-2 gap-4">
              <div className="text-center p-4 bg-secondary-50 rounded-2xl">
                <div className="text-2xl font-bold text-secondary-600 mb-1">
                  ৳{totalIncome.toLocaleString()}
                </div>
                <div className="text-sm text-gray-600">Total Income</div>
              </div>
              <div className="text-center p-4 bg-red-50 rounded-2xl">
                <div className="text-2xl font-bold text-red-600 mb-1">
                  ৳{totalExpenses.toLocaleString()}
                </div>
                <div className="text-sm text-gray-600">Total Expenses</div>
              </div>
            </div>
            <div className="mt-4 p-4 bg-gray-50 rounded-2xl text-center">
              <div className={`text-2xl font-bold mb-1 ${
                totalIncome - totalExpenses >= 0 ? 'text-secondary-600' : 'text-red-600'
              }`}>
                ৳{Math.abs(totalIncome - totalExpenses).toLocaleString()}
              </div>
              <div className="text-sm text-gray-600">
                Net {totalIncome - totalExpenses >= 0 ? 'Savings' : 'Deficit'}
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};