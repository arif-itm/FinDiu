import React, { useState } from 'react';
import { ArrowLeft, Plus, Target, TrendingUp, X, Save, Banknote } from 'lucide-react';
import { Screen } from '../types';
import { mockSavingsGoals } from '../data/mockData';

interface SavingsScreenProps {
  onNavigate: (screen: Screen) => void;
}

export const SavingsScreen: React.FC<SavingsScreenProps> = ({ onNavigate }) => {
  const [showCreateModal, setShowCreateModal] = useState(false);
  const [showAddMoneyModal, setShowAddMoneyModal] = useState(false);
  const [selectedGoalId, setSelectedGoalId] = useState<string>('');
  const [addAmount, setAddAmount] = useState('');
  const [newGoal, setNewGoal] = useState({
    title: '',
    targetAmount: '',
    deadline: '',
    category: 'Education'
  });

  const categories = [
    { name: 'Education', color: 'bg-blue-500' },
    { name: 'Technology', color: 'bg-purple-500' },
    { name: 'Emergency', color: 'bg-orange-500' },
    { name: 'Travel', color: 'bg-green-500' },
    { name: 'Books', color: 'bg-red-500' },
    { name: 'Other', color: 'bg-gray-500' }
  ];

  const handleCreateGoal = () => {
    if (newGoal.title && newGoal.targetAmount && newGoal.deadline) {
      // Here you would typically save to your data store
      console.log('Creating new goal:', newGoal);
      setShowCreateModal(false);
      setNewGoal({ title: '', targetAmount: '', deadline: '', category: 'Education' });
      // Show success message or refresh goals list
    }
  };

  const handleCreateNewGoal = () => {
    setShowCreateModal(true);
  };

  const handleAddMoney = (goalId: string) => {
    setSelectedGoalId(goalId);
    setShowAddMoneyModal(true);
  };

  const handleConfirmAddMoney = () => {
    if (addAmount && selectedGoalId) {
      // Here you would typically update the goal's current amount
      console.log(`Adding ৳${addAmount} to goal ${selectedGoalId}`);
      setShowAddMoneyModal(false);
      setAddAmount('');
      setSelectedGoalId('');
      // Show success message and update the goal
    }
  };

  const selectedGoal = mockSavingsGoals.find(goal => goal.id === selectedGoalId);

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <div className="bg-gradient-to-r from-secondary-500 to-primary-500 px-6 py-4 text-white">
        <div className="flex items-center space-x-4 mb-6">
          <button
            onClick={() => onNavigate('dashboard')}
            className="w-10 h-10 bg-white/20 rounded-2xl flex items-center justify-center hover:bg-white/30 transition-colors backdrop-blur-sm"
          >
            <ArrowLeft className="w-5 h-5" />
          </button>
          <h1 className="text-xl font-bold">Savings Goals</h1>
        </div>

        {/* Total Savings */}
        <div className="bg-white/10 backdrop-blur-sm rounded-3xl p-6">
          <div className="text-center">
            <div className="text-sm opacity-80 mb-1">Total Saved</div>
            <div className="text-3xl font-bold mb-4">৳79,500</div>
            <div className="flex items-center justify-center space-x-2 text-sm opacity-90">
              <TrendingUp className="w-4 h-4" />
              <span>+12% this month</span>
            </div>
          </div>
        </div>
      </div>

      <div className="px-6 -mt-6 pb-6">
        {/* Add New Goal Button */}
        <div className="mb-6">
          <button 
            onClick={handleCreateNewGoal}
            className="w-full bg-white rounded-3xl p-4 shadow-sm flex items-center justify-center space-x-3 hover:shadow-md transition-all hover:scale-[1.02] active:scale-[0.98]"
          >
            <div className="w-12 h-12 bg-gradient-to-r from-secondary-500 to-primary-500 rounded-2xl flex items-center justify-center">
              <Plus className="w-6 h-6 text-white" />
            </div>
            <div className="text-left">
              <div className="font-semibold text-gray-900">Create New Goal</div>
              <div className="text-sm text-gray-600">Start saving for something special</div>
            </div>
          </button>
        </div>

        {/* Savings Goals */}
        <div className="space-y-4">
          {mockSavingsGoals.map((goal) => {
            const progress = (goal.currentAmount / goal.targetAmount) * 100;
            const daysLeft = Math.ceil((new Date(goal.deadline).getTime() - new Date().getTime()) / (1000 * 60 * 60 * 24));
            
            return (
              <div key={goal.id} className="bg-white rounded-3xl p-6 shadow-sm">
                <div className="flex items-start justify-between mb-4">
                  <div className="flex items-center space-x-3">
                    <div className={`w-12 h-12 ${goal.color} rounded-2xl flex items-center justify-center`}>
                      <Target className="w-6 h-6 text-white" />
                    </div>
                    <div>
                      <h3 className="font-semibold text-gray-900">{goal.title}</h3>
                      <p className="text-sm text-gray-600">{goal.category}</p>
                    </div>
                  </div>
                  <div className="text-right">
                    <div className="text-sm text-gray-600">{daysLeft} days left</div>
                  </div>
                </div>

                <div className="mb-4">
                  <div className="flex justify-between text-sm mb-2">
                    <span className="text-gray-600">Progress</span>
                    <span className="font-semibold">{progress.toFixed(0)}%</span>
                  </div>
                  <div className="w-full bg-gray-200 rounded-full h-3">
                    <div
                      className={`h-3 rounded-full transition-all duration-300 ${goal.color}`}
                      style={{ width: `${progress}%` }}
                    ></div>
                  </div>
                </div>

                <div className="flex justify-between items-center mb-4">
                  <div>
                    <div className="text-sm text-gray-600">Saved</div>
                    <div className="font-bold text-lg">৳{goal.currentAmount.toLocaleString()}</div>
                  </div>
                  <div className="text-right">
                    <div className="text-sm text-gray-600">Target</div>
                    <div className="font-bold text-lg">৳{goal.targetAmount.toLocaleString()}</div>
                  </div>
                </div>

                <button 
                  onClick={() => handleAddMoney(goal.id)}
                  className="w-full bg-gray-50 hover:bg-gray-100 text-gray-900 py-3 rounded-2xl font-medium transition-all hover:scale-[1.02] active:scale-[0.98] flex items-center justify-center space-x-2"
                >
                  <span className="text-lg font-bold">৳</span>
                  <span>Add Money</span>
                </button>
              </div>
            );
          })}
        </div>
      </div>

      {/* Create Goal Modal */}
      {showCreateModal && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center p-6 z-50">
          <div className="bg-white rounded-3xl p-6 w-full max-w-md max-h-[90vh] overflow-y-auto">
            <div className="flex items-center justify-between mb-6">
              <h2 className="text-xl font-bold text-gray-900">Create New Goal</h2>
              <button
                onClick={() => setShowCreateModal(false)}
                className="w-8 h-8 bg-gray-100 rounded-full flex items-center justify-center hover:bg-gray-200 transition-colors"
              >
                <X className="w-4 h-4 text-gray-600" />
              </button>
            </div>

            <div className="space-y-4">
              {/* Goal Title */}
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Goal Title</label>
                <input
                  type="text"
                  placeholder="e.g., New Laptop, Study Abroad"
                  value={newGoal.title}
                  onChange={(e) => setNewGoal({...newGoal, title: e.target.value})}
                  className="w-full px-4 py-3 border border-gray-200 rounded-2xl focus:border-primary-500 focus:ring-2 focus:ring-primary-200 outline-none transition-all"
                />
              </div>

              {/* Target Amount */}
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Target Amount</label>
                <div className="relative">
                  <span className="absolute left-4 top-1/2 transform -translate-y-1/2 text-lg font-bold text-gray-400">৳</span>
                  <input
                    type="number"
                    placeholder="0"
                    value={newGoal.targetAmount}
                    onChange={(e) => setNewGoal({...newGoal, targetAmount: e.target.value})}
                    className="w-full pl-10 pr-4 py-3 border border-gray-200 rounded-2xl focus:border-primary-500 focus:ring-2 focus:ring-primary-200 outline-none transition-all"
                  />
                </div>
              </div>

              {/* Category */}
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Category</label>
                <div className="grid grid-cols-2 gap-2">
                  {categories.map((category) => (
                    <button
                      key={category.name}
                      onClick={() => setNewGoal({...newGoal, category: category.name})}
                      className={`flex items-center space-x-2 p-3 rounded-2xl border-2 transition-all ${
                        newGoal.category === category.name
                          ? 'border-primary-500 bg-primary-50'
                          : 'border-gray-200 hover:border-gray-300'
                      }`}
                    >
                      <div className={`w-6 h-6 ${category.color} rounded-lg`}></div>
                      <span className="text-sm font-medium text-gray-900">{category.name}</span>
                    </button>
                  ))}
                </div>
              </div>

              {/* Deadline */}
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Target Date</label>
                <input
                  type="date"
                  value={newGoal.deadline}
                  onChange={(e) => setNewGoal({...newGoal, deadline: e.target.value})}
                  className="w-full px-4 py-3 border border-gray-200 rounded-2xl focus:border-primary-500 focus:ring-2 focus:ring-primary-200 outline-none transition-all"
                />
              </div>
            </div>

            {/* Action Buttons */}
            <div className="flex space-x-3 mt-6">
              <button
                onClick={() => setShowCreateModal(false)}
                className="flex-1 bg-gray-100 hover:bg-gray-200 text-gray-900 py-3 rounded-2xl font-medium transition-colors"
              >
                Cancel
              </button>
              <button
                onClick={handleCreateGoal}
                disabled={!newGoal.title || !newGoal.targetAmount || !newGoal.deadline}
                className="flex-1 bg-gradient-to-r from-secondary-500 to-primary-500 text-white py-3 rounded-2xl font-medium hover:shadow-lg transition-all transform hover:scale-[1.02] disabled:opacity-50 disabled:transform-none disabled:shadow-none flex items-center justify-center space-x-2"
              >
                <Save className="w-4 h-4" />
                <span>Create Goal</span>
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Add Money Modal */}
      {showAddMoneyModal && selectedGoal && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center p-6 z-50">
          <div className="bg-white rounded-3xl p-6 w-full max-w-md">
            <div className="flex items-center justify-between mb-6">
              <h2 className="text-xl font-bold text-gray-900">Add Money</h2>
              <button
                onClick={() => setShowAddMoneyModal(false)}
                className="w-8 h-8 bg-gray-100 rounded-full flex items-center justify-center hover:bg-gray-200 transition-colors"
              >
                <X className="w-4 h-4 text-gray-600" />
              </button>
            </div>

            {/* Goal Info */}
            <div className="bg-gray-50 rounded-2xl p-4 mb-6">
              <div className="flex items-center space-x-3 mb-2">
                <div className={`w-10 h-10 ${selectedGoal.color} rounded-2xl flex items-center justify-center`}>
                  <Target className="w-5 h-5 text-white" />
                </div>
                <div>
                  <h3 className="font-semibold text-gray-900">{selectedGoal.title}</h3>
                  <p className="text-sm text-gray-600">{selectedGoal.category}</p>
                </div>
              </div>
              <div className="text-sm text-gray-600">
                Current: ৳{selectedGoal.currentAmount.toLocaleString()} / ৳{selectedGoal.targetAmount.toLocaleString()}
              </div>
            </div>

            {/* Amount Input */}
            <div className="mb-6">
              <label className="block text-sm font-medium text-gray-700 mb-2">Amount to Add</label>
              <div className="relative">
                <span className="absolute left-4 top-1/2 transform -translate-y-1/2 text-2xl font-bold text-gray-400">৳</span>
                <input
                  type="number"
                  placeholder="0"
                  value={addAmount}
                  onChange={(e) => setAddAmount(e.target.value)}
                  className="w-full pl-12 pr-4 py-4 text-2xl font-bold text-gray-900 border-2 border-gray-200 rounded-2xl focus:border-primary-500 focus:ring-2 focus:ring-primary-200 outline-none transition-all"
                />
              </div>
            </div>

            {/* Quick Amount Buttons */}
            <div className="grid grid-cols-3 gap-3 mb-6">
              {[500, 1000, 2000].map((amount) => (
                <button
                  key={amount}
                  onClick={() => setAddAmount(amount.toString())}
                  className="bg-gray-100 hover:bg-gray-200 text-gray-900 py-2 rounded-xl font-medium transition-colors"
                >
                  ৳{amount}
                </button>
              ))}
            </div>

            {/* Action Buttons */}
            <div className="flex space-x-3">
              <button
                onClick={() => setShowAddMoneyModal(false)}
                className="flex-1 bg-gray-100 hover:bg-gray-200 text-gray-900 py-3 rounded-2xl font-medium transition-colors"
              >
                Cancel
              </button>
              <button
                onClick={handleConfirmAddMoney}
                disabled={!addAmount || parseFloat(addAmount) <= 0}
                className="flex-1 bg-gradient-to-r from-secondary-500 to-primary-500 text-white py-3 rounded-2xl font-medium hover:shadow-lg transition-all transform hover:scale-[1.02] disabled:opacity-50 disabled:transform-none disabled:shadow-none flex items-center justify-center space-x-2"
              >
                <span className="text-lg font-bold">৳</span>
                <span>Add Money</span>
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};