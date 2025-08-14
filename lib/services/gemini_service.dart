import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/chat_message.dart';
import '../models/transaction.dart' as AppTransaction;

class GeminiService {
  late final GenerativeModel _model;
  static const String _apiKey = 'YOUR_GEMINI_API_KEY'; // Replace with your actual API key

  GeminiService() {
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: _apiKey,
    );
  }

  // Generate financial advice based on user's transaction history
  Future<String> getFinancialAdvice(List<AppTransaction.Transaction> transactions) async {
    final prompt = _buildFinancialAdvicePrompt(transactions);
    
    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return response.text ?? 'Unable to generate advice at this time.';
    } catch (e) {
      return 'Error generating financial advice: $e';
    }
  }

  // Chat with AI assistant
  Future<String> chatWithAI(String userMessage, List<ChatMessage> chatHistory) async {
    try {
      final prompt = _buildChatPrompt(userMessage, chatHistory);
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return response.text ?? 'I apologize, but I cannot respond right now.';
    } catch (e) {
      return 'Error: Unable to process your message. Please try again.';
    }
  }

  // Generate spending insights
  Future<String> getSpendingInsights(Map<String, double> categoryExpenses, double totalIncome) async {
    final prompt = _buildSpendingInsightsPrompt(categoryExpenses, totalIncome);
    
    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return response.text ?? 'Unable to generate insights at this time.';
    } catch (e) {
      return 'Error generating spending insights: $e';
    }
  }

  // Generate savings suggestions
  Future<String> getSavingsSuggestions(
    double currentBalance,
    double monthlyIncome,
    double monthlyExpenses,
  ) async {
    final prompt = _buildSavingsSuggestionsPrompt(currentBalance, monthlyIncome, monthlyExpenses);
    
    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return response.text ?? 'Unable to generate savings suggestions at this time.';
    } catch (e) {
      return 'Error generating savings suggestions: $e';
    }
  }

  // Private helper methods to build prompts
  String _buildFinancialAdvicePrompt(List<AppTransaction.Transaction> transactions) {
    final StringBuffer prompt = StringBuffer();
    prompt.writeln('You are a helpful financial advisor for students. Based on the following transaction history, provide personalized financial advice:');
    prompt.writeln('');
    
    if (transactions.isEmpty) {
      prompt.writeln('No transactions available. Provide general financial advice for students.');
    } else {
      prompt.writeln('Recent transactions:');
      for (int i = 0; i < transactions.length && i < 10; i++) {
        final transaction = transactions[i];
        prompt.writeln('- ${transaction.type.name}: \$${transaction.amount.toStringAsFixed(2)} - ${transaction.category} (${transaction.description})');
      }
    }
    
    prompt.writeln('');
    prompt.writeln('Please provide:');
    prompt.writeln('1. Overall financial health assessment');
    prompt.writeln('2. Specific recommendations for improvement');
    prompt.writeln('3. Student-friendly money-saving tips');
    prompt.writeln('4. Budgeting advice relevant to student life');
    prompt.writeln('');
    prompt.writeln('Keep the response concise, actionable, and tailored for students. Use a friendly and encouraging tone.');
    
    return prompt.toString();
  }

  String _buildChatPrompt(String userMessage, List<ChatMessage> chatHistory) {
    final StringBuffer prompt = StringBuffer();
    prompt.writeln('You are FinDiu, an AI financial assistant specifically designed for students. You help with:');
    prompt.writeln('- Personal finance management');
    prompt.writeln('- Budgeting for students');
    prompt.writeln('- Saving strategies for limited budgets');
    prompt.writeln('- Financial goal setting');
    prompt.writeln('- Student-specific financial advice');
    prompt.writeln('');
    
    if (chatHistory.isNotEmpty) {
      prompt.writeln('Previous conversation:');
      for (final message in chatHistory.take(5)) {
        prompt.writeln('${message.isUser ? "User" : "FinDiu"}: ${message.message}');
      }
      prompt.writeln('');
    }
    
    prompt.writeln('Current user message: $userMessage');
    prompt.writeln('');
    prompt.writeln('Respond as FinDiu with helpful, student-focused financial advice. Be friendly, concise, and practical.');
    
    return prompt.toString();
  }

  String _buildSpendingInsightsPrompt(Map<String, double> categoryExpenses, double totalIncome) {
    final StringBuffer prompt = StringBuffer();
    prompt.writeln('You are a financial analyst providing spending insights for a student. Based on the following data:');
    prompt.writeln('');
    prompt.writeln('Monthly Income: \$${totalIncome.toStringAsFixed(2)}');
    prompt.writeln('Spending by category:');
    
    categoryExpenses.forEach((category, amount) {
      final percentage = totalIncome > 0 ? (amount / totalIncome * 100) : 0;
      prompt.writeln('- $category: \$${amount.toStringAsFixed(2)} (${percentage.toStringAsFixed(1)}%)');
    });
    
    prompt.writeln('');
    prompt.writeln('Provide:');
    prompt.writeln('1. Analysis of spending patterns');
    prompt.writeln('2. Areas where the student might be overspending');
    prompt.writeln('3. Recommendations for better budget allocation');
    prompt.writeln('4. Student-specific money-saving opportunities');
    prompt.writeln('');
    prompt.writeln('Be specific and actionable in your advice.');
    
    return prompt.toString();
  }

  String _buildSavingsSuggestionsPrompt(double currentBalance, double monthlyIncome, double monthlyExpenses) {
    final StringBuffer prompt = StringBuffer();
    prompt.writeln('You are a financial advisor helping a student with savings strategies. Current financial situation:');
    prompt.writeln('');
    prompt.writeln('Current Balance: \$${currentBalance.toStringAsFixed(2)}');
    prompt.writeln('Monthly Income: \$${monthlyIncome.toStringAsFixed(2)}');
    prompt.writeln('Monthly Expenses: \$${monthlyExpenses.toStringAsFixed(2)}');
    
    final surplus = monthlyIncome - monthlyExpenses;
    prompt.writeln('Monthly Surplus/Deficit: \$${surplus.toStringAsFixed(2)}');
    prompt.writeln('');
    
    prompt.writeln('Provide personalized savings suggestions including:');
    prompt.writeln('1. Realistic savings goals for a student budget');
    prompt.writeln('2. Strategies to increase savings');
    prompt.writeln('3. Emergency fund recommendations');
    prompt.writeln('4. Long-term financial planning tips for students');
    prompt.writeln('5. Ways to generate additional income as a student');
    prompt.writeln('');
    prompt.writeln('Consider the student\'s limited income and provide practical, achievable advice.');
    
    return prompt.toString();
  }
}
