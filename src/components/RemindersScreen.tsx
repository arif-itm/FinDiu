import React from 'react';
import { ArrowLeft, Bell, Clock, CheckCircle, Circle, Plus } from 'lucide-react';
import { Screen } from '../types';
import { mockReminders } from '../data/mockData';

interface RemindersScreenProps {
  onNavigate: (screen: Screen) => void;
}

export const RemindersScreen: React.FC<RemindersScreenProps> = ({ onNavigate }) => {
  const getTypeIcon = (type: string) => {
    switch (type) {
      case 'bill': return '💡';
      case 'payment': return '🎓';
      case 'deadline': return '📝';
      default: return '⏰';
    }
  };

  const formatDate = (dateString: string) => {
    const date = new Date(dateString);
    const today = new Date();
    const diffTime = date.getTime() - today.getTime();
    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

    if (diffDays === 0) return 'Today';
    if (diffDays === 1) return 'Tomorrow';
    if (diffDays < 0) return `${Math.abs(diffDays)} days overdue`;
    return `In ${diffDays} days`;
  };

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <div className="bg-gradient-to-r from-accent-500 to-secondary-500 px-6 py-4 text-white">
        <div className="flex items-center space-x-4 mb-6">
          <button
            onClick={() => onNavigate('dashboard')}
            className="w-10 h-10 bg-white/20 rounded-2xl flex items-center justify-center hover:bg-white/30 transition-colors backdrop-blur-sm"
          >
            <ArrowLeft className="w-5 h-5" />
          </button>
          <h1 className="text-xl font-bold">Reminders</h1>
        </div>

        {/* Stats */}
        <div className="bg-white/10 backdrop-blur-sm rounded-3xl p-6">
          <div className="grid grid-cols-2 gap-4">
            <div className="text-center">
              <div className="text-2xl font-bold">2</div>
              <div className="text-sm opacity-80">Pending</div>
            </div>
            <div className="text-center">
              <div className="text-2xl font-bold">1</div>
              <div className="text-sm opacity-80">Completed</div>
            </div>
          </div>
        </div>
      </div>

      <div className="px-6 -mt-6 pb-6">
        {/* Add Reminder Button */}
        <div className="mb-6">
          <button className="w-full bg-white rounded-3xl p-4 shadow-sm flex items-center justify-center space-x-3 hover:shadow-md transition-all">
            <div className="w-12 h-12 bg-gradient-to-r from-accent-500 to-secondary-500 rounded-2xl flex items-center justify-center">
              <Plus className="w-6 h-6 text-white" />
            </div>
            <div className="text-left">
              <div className="font-semibold text-gray-900">Add Reminder</div>
              <div className="text-sm text-gray-600">Never miss a payment again</div>
            </div>
          </button>
        </div>

        {/* Reminders List */}
        <div className="space-y-4">
          {mockReminders.map((reminder) => {
            const isOverdue = new Date(reminder.dueDate) < new Date() && !reminder.isCompleted;
            const daysDiff = formatDate(reminder.dueDate);

            return (
              <div
                key={reminder.id}
                className={`bg-white rounded-3xl p-6 shadow-sm border-l-4 ${
                  reminder.isCompleted
                    ? 'border-secondary-500'
                    : isOverdue
                    ? 'border-red-500'
                    : 'border-yellow-500'
                }`}
              >
                <div className="flex items-start space-x-4">
                  <div className="text-2xl">{getTypeIcon(reminder.type)}</div>
                  <div className="flex-1">
                    <div className="flex items-center space-x-2 mb-2">
                      <h3 className={`font-semibold ${reminder.isCompleted ? 'text-gray-500 line-through' : 'text-gray-900'}`}>
                        {reminder.title}
                      </h3>
                      <button className="ml-auto">
                        {reminder.isCompleted ? (
                          <CheckCircle className="w-6 h-6 text-secondary-500" />
                        ) : (
                          <Circle className="w-6 h-6 text-gray-400 hover:text-primary-500 transition-colors" />
                        )}
                      </button>
                    </div>

                    <div className="flex items-center space-x-4 text-sm text-gray-600 mb-3">
                      <div className="flex items-center space-x-1">
                        <Clock className="w-4 h-4" />
                        <span className={isOverdue && !reminder.isCompleted ? 'text-red-600 font-medium' : ''}>
                          {daysDiff}
                        </span>
                      </div>
                      {reminder.amount > 0 && (
                        <div className="flex items-center space-x-1">
                          <Bell className="w-4 h-4" />
                          <span>৳{reminder.amount.toLocaleString()}</span>
                        </div>
                      )}
                    </div>

                    {!reminder.isCompleted && (
                      <button className="bg-primary-50 hover:bg-primary-100 text-primary-700 px-4 py-2 rounded-xl text-sm font-medium transition-colors">
                        Mark as Done
                      </button>
                    )}
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      </div>
    </div>
  );
};