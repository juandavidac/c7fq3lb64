class ExpensesController < ApplicationController
  def index
    if params[:category_id].blank? && params[:concept].blank?
      @expenses = Expense.order("date DESC")
    elsif params[:concept] && params[:category_id].blank?
      concept=params[:concept].split
      concept.reject!{|x| x.length<=3}
      expense=Expense.all
      @expenses=[]
      expense.each do |hash|
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
      @category=Category.find(params[:category_id])
      @expenses=@category.expenses.all
      @current=@category.name
    elsif params[:concept] && params[:category_id]


      @category=Category.find(params[:category_id])
      @expensescategory=@category.expenses.all


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
      @current=@category.name+", "+params[:concept]
      #@expenses=@expensesunordered.sort {|a,b| b.date <=> a.date}

    else
      @expenses = Expense.order("date DESC")
    end
  end
end

#  elsif params[:category_id].nil? || params[:concept].nil?
#    @expenses = Expense.order("date DESC")
