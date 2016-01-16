class ExpensesController < ApplicationController
  before_action :authenticate_user!
  #bef ore_action :private_access

  def index
    if params[:category_id].blank? && params[:concept].blank?
      @expenses=User.find(current_user.id).expenses.all

    elsif params[:concept] && params[:category_id].blank?
      concept=params[:concept].split
      concept.reject!{|x| x.length<=3}
      expenses_user=User.find(current_user.id).expenses.all
      @expenses=[]
      expenses_user.each do |hash|
          if concept.any? {|w| hash[:concept] =~ /#{w}/ }
            @expenses << hash
          end
      end

      #concept=params[:concept]
      #expense=Expense.all  Podmeos obtener una array con hash y aplicar ruby
      #@expenses=expense.select{|x| x[:concept]==concept}

      #Estos dos funcionan solitos
      #@expenses=Expense.where(concept: "#{params[:concept]}").to_a
      @current=params[:concept]
    elsif params[:category_id] && params[:concept].blank?

      @expenses=Expense.where(category_id: params[:category_id], user_id: current_user.id).to_a
      @current=params[:category_id]

    elsif params[:concept] && params[:category_id]

      @expensescategory=Expense.where(category_id: params[:category_id], user_id: current_user.id).to_a


      #@expensesconcept=Expense.where(concept: "#{params[:concept]}").to_a
      concept=params[:concept].split
      concept.reject!{|x| x.length<=3}
      #expense=Expense.all
      @expensesconcept=[]
      @expensescategory.each do |hash|
          if concept.any? {|w| hash[:concept] =~ /#{w}/ }
            @expensesconcept << hash
          end
      end

      @expenses=@expensesconcept

      #@expenses=(@expensescategory|@expensesconcept).sort {|a,b| b.date <=> a.date}
      @current=params[:category_id]+", "+params[:concept]
      #@expenses=@expensesunordered.sort {|a,b| b.date <=> a.date}

    else
      @expenses = Expense.order("date DESC")
    end
  end
end

#  elsif params[:category_id].nil? || params[:concept].nil?
#    @expenses = Expense.order("date DESC")
