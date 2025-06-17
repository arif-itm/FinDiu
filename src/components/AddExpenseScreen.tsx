import React, { useState } from 'react';
import { ArrowLeft, Calculator, Tag, Calendar, Check } from 'lucide-react';
import { Screen } from '../types';

interface AddExpenseScreenProps {
  onNavigate: (screen: Screen) => void;
}

const categories = [
  { name: 'Tuition', color: 'bg-blue-500', icon: '🎓' },
  { name: 'Campus Food', color: 'bg-orange-500', icon: '🍽️' },
  { name: 'One Card', color: 'bg-purple-500', icon: '💳' },
  { name: 'Coffee', color: 'bg-amber-500', icon: '☕' },
  { name: 'Exam Fees', color: 'bg-red-500', icon: '📝' },
  { name: 'Books & Supplies', color: 'bg-green-500', icon: '📚' },
  { name: 'Transport', color: 'bg-cyan-500', icon: '🚌' },
  { name: 'Hall Fees', color: 'bg-pink-500', icon: '🏢' },
];

export const AddExpenseScreen: React.FC<AddExpenseScreenProps> = ({ onNavigate }) => {
  const [amount, setAmount] = useState('');
  const [description, setDescription] = useState('');
  const [selectedCategory, setSelectedCategory] = useState('');
  const [showSuccess, setShowSuccess] = useState(false);

  const handleAddExpense = () => {
    if (amount && description && selectedCategory) {
      setShowSuccess(true);
      setTimeout(() => {
        onNavigate('dashboard');
      }, 1500);
    }
  };

  if (showSuccess) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-secondary-500 to-primary-500 flex items-center justify-center">
        <div className="text-center text-white">
          <div className="w-20 h-20 bg-white/20 rounded-full flex items-center justify-center mx-auto mb-4 backdrop-blur-sm">
            <Check className="w-10 h-10" />
          </div>
          <h2 className="text-2xl font-bold mb-2">Expense Added!</h2>
          <p className="text-lg opacity-90">Your campus transaction has been recorded</p>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <div className="bg-white px-6 py-4 border-b border-gray-100">
        <div className="flex items-center space-x-4">
          <button
            onClick={() => onNavigate('dashboard')}
            className="w-10 h-10 bg-gray-100 rounded-2xl flex items-center justify-center hover:bg-gray-200 transition-colors"
          >
            <ArrowLeft className="w-5 h-5 text-gray-700" />
          </button>
          <h1 className="text-xl font-bold text-gray-900">Add Campus Expense</h1>
        </div>
      </div>

      <div className="px-6 py-6 space-y-6">
        {/* Amount Input */}
        <div className="bg-white rounded-3xl p-6 shadow-sm">
          <div className="flex items-center space-x-3 mb-4">
            <Calculator className="w-6 h-6 text-primary-500" />
            <h2 className="text-lg font-semibold text-gray-900">Amount</h2>
          </div>
          <div className="relative">
            <span className="absolute left-4 top-1/2 transform -translate-y-1/2 text-2xl font-bold text-gray-400">৳</span>
            <input
              type="number"
              placeholder="0"
              value={amount}
              onChange={(e) => setAmount(e.target.value)}
              className="w-full pl-12 pr-4 py-4 text-3xl font-bold text-gray-900 border-2 border-gray-200 rounded-2xl focus:border-primary-500 focus:ring-2 focus:ring-primary-200 outline-none transition-all"
            />
          </div>
        </div>

        {/* Description */}
        <div className="bg-white rounded-3xl p-6 shadow-sm">
          <div className="flex items-center space-x-3 mb-4">
            <Tag className="w-6 h-6 text-primary-500" />
            <h2 className="text-lg font-semibold text-gray-900">Description</h2>
          </div>
          <input
            type="text"
            placeholder="What did you spend on? (e.g., Green Garden lunch, Coffee at library)"
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            className="w-full px-4 py-3 border-2 border-gray-200 rounded-2xl focus:border-primary-500 focus:ring-2 focus:ring-primary-200 outline-none transition-all"
          />
        </div>

        {/* Category Selection */}
        <div className="bg-white rounded-3xl p-6 shadow-sm">
          <div className="flex items-center space-x-3 mb-4">
            <Calendar className="w-6 h-6 text-primary-500" />
            <h2 className="text-lg font-semibold text-gray-900">Campus Category</h2>
          </div>
          <div className="grid grid-cols-2 gap-3">
            {categories.map((category) => (
              <button
                key={category.name}
                onClick={() => setSelectedCategory(category.name)}
                className={`flex items-center space-x-3 p-4 rounded-2xl border-2 transition-all ${
                  selectedCategory === category.name
                    ? 'border-primary-500 bg-primary-50'
                    : 'border-gray-200 hover:border-gray-300'
                }`}
              >
                <div className={`w-10 h-10 ${category.color} rounded-xl flex items-center justify-center text-white text-lg`}>
                  {category.icon}
                </div>
                <span className="font-medium text-gray-900 text-sm">{category.name}</span>
              </button>
            ))}
          </div>
        </div>

        {/* Add Button */}
        <button
          onClick={handleAddExpense}
          disabled={!amount || !description || !selectedCategory}
          className="w-full bg-gradient-to-r from-primary-500 to-accent-500 text-white py-4 rounded-2xl font-semibold text-lg hover:shadow-lg transition-all transform hover:scale-[1.02] disabled:opacity-50 disabled:transform-none disabled:shadow-none"
        >
          Add Campus Expense
        </button>
      </div>
    </div>
  );
};