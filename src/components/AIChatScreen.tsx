import React, { useState } from 'react';
import { ArrowLeft, Send, Bot, User } from 'lucide-react';
import { Screen } from '../types';
import { mockChatMessages } from '../data/mockData';

interface AIChatScreenProps {
  onNavigate: (screen: Screen) => void;
}

export const AIChatScreen: React.FC<AIChatScreenProps> = ({ onNavigate }) => {
  const [messages, setMessages] = useState(mockChatMessages);
  const [newMessage, setNewMessage] = useState('');

  const handleSendMessage = () => {
    if (newMessage.trim()) {
      const userMessage = {
        id: `user-${Date.now()}`,
        message: newMessage,
        isUser: true,
        timestamp: new Date().toISOString()
      };

      const aiResponse = {
        id: `ai-${Date.now()}`,
        message: "I understand your campus financial question! Let me analyze your spending patterns and provide personalized advice. Based on your recent transactions, I can help you make better decisions about tuition, campus food, and student budgets.",
        isUser: false,
        timestamp: new Date().toISOString()
      };

      setMessages(prev => [...prev, userMessage, aiResponse]);
      setNewMessage('');
    }
  };

  const quickQuestions = [
    "Can I afford Green Garden daily?",
    "How to save for next semester?",
    "Best campus meal plan?",
    "One Card budget tips"
  ];

  return (
    <div className="min-h-screen bg-gray-50 flex flex-col">
      {/* Header */}
      <div className="bg-gradient-to-r from-primary-500 to-accent-500 px-6 py-4 text-white">
        <div className="flex items-center space-x-4">
          <button
            onClick={() => onNavigate('dashboard')}
            className="w-10 h-10 bg-white/20 rounded-2xl flex items-center justify-center hover:bg-white/30 transition-colors backdrop-blur-sm"
          >
            <ArrowLeft className="w-5 h-5" />
          </button>
          <div className="flex items-center space-x-3">
            <div className="w-10 h-10 bg-white/20 rounded-2xl flex items-center justify-center backdrop-blur-sm">
              <Bot className="w-5 h-5" />
            </div>
            <div>
              <h1 className="text-lg font-bold">Campus AI Assistant</h1>
              <p className="text-sm opacity-80">Your student financial advisor</p>
            </div>
          </div>
        </div>
      </div>

      {/* Messages */}
      <div className="flex-1 px-6 py-6 space-y-4 overflow-y-auto">
        {messages.map((message) => (
          <div
            key={message.id}
            className={`flex ${message.isUser ? 'justify-end' : 'justify-start'}`}
          >
            <div className="flex items-start space-x-3 max-w-xs">
              {!message.isUser && (
                <div className="w-8 h-8 bg-primary-100 rounded-2xl flex items-center justify-center flex-shrink-0">
                  <Bot className="w-4 h-4 text-primary-600" />
                </div>
              )}
              <div
                className={`p-4 rounded-3xl ${
                  message.isUser
                    ? 'bg-primary-500 text-white rounded-br-lg'
                    : 'bg-white text-gray-900 shadow-sm rounded-bl-lg'
                }`}
              >
                <p className="text-sm leading-relaxed">{message.message}</p>
                <p className={`text-xs mt-2 ${message.isUser ? 'text-primary-100' : 'text-gray-500'}`}>
                  {new Date(message.timestamp).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
                </p>
              </div>
              {message.isUser && (
                <div className="w-8 h-8 bg-primary-500 rounded-2xl flex items-center justify-center flex-shrink-0">
                  <User className="w-4 h-4 text-white" />
                </div>
              )}
            </div>
          </div>
        ))}
      </div>

      {/* Quick Questions */}
      <div className="px-6 pb-4">
        <div className="flex space-x-2 overflow-x-auto">
          {quickQuestions.map((question, index) => (
            <button
              key={index}
              onClick={() => setNewMessage(question)}
              className="bg-white text-gray-700 px-4 py-2 rounded-2xl text-sm font-medium whitespace-nowrap shadow-sm hover:shadow-md transition-all"
            >
              {question}
            </button>
          ))}
        </div>
      </div>

      {/* Message Input */}
      <div className="px-6 pb-6">
        <div className="bg-white rounded-3xl p-4 shadow-sm">
          <div className="flex items-center space-x-3">
            <input
              type="text"
              placeholder="Ask me about campus finances, tuition, or budgeting..."
              value={newMessage}
              onChange={(e) => setNewMessage(e.target.value)}
              onKeyPress={(e) => e.key === 'Enter' && handleSendMessage()}
              className="flex-1 outline-none text-gray-900 placeholder-gray-500"
            />
            <button
              onClick={handleSendMessage}
              disabled={!newMessage.trim()}
              className="w-10 h-10 bg-primary-500 rounded-2xl flex items-center justify-center hover:bg-primary-600 transition-colors disabled:bg-gray-300"
            >
              <Send className="w-5 h-5 text-white" />
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};