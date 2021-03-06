# frozen_string_literal: true

class Answer < ApplicationRecord
  @@choices = []
  @@days = ''
  @@removed_items = []

  def initialize(_attributes = {})
    @@choices.push('always = true')
    @@choices.push('category_id = 1')
    @@choices.push('category_id = 2')
  end

  def choices
    @@choices
  end

  def choices=(choice)
    @@choices = choice
  end

  def add_choice(value)
    return unless @@choices.nil? || @@choices != value

    @@choices.push value
  end

  def days
    @@days
  end

  def days=(days)
    @@days = days
  end

  def remove_choice(value)
    @@choices.delete_if { |choice| choice == value }
  end

  def remove_from_list(item)
    @@removed_items.push(item.strip)
  end

  def removed_items
    @@removed_items
  end

  def removed_items=(items)
    @@removed_items = items
  end

  def sort_list_by_category(combined_list, list)
    list.each do |item|
      push_item(combined_list, item)
    end
  end

  def push_item(combined_list, item)
    category = determine_category(item)
    combined_list[category].push(item.name)
  end

  def determine_category(item)
    if item.clothing?
      :clothing
    elsif item.category_id == 1
      :toiletries
    elsif item.category_id == 2
      :electronics
    else
      :accessories
    end
  end

  def remove_items(combined_list, items)
    combined_list.each do |key, _val|
      combined_list[key] = combined_list[key] - items
    end
  end

  def list
    combined_list = { clothing: [], electronics: [], toiletries: [], accessories: [] }
    unless @@choices.empty? || @@choices.nil?
      query = @@choices.join(' OR ')
      list = Item.where(query).all
    end
    sort_list_by_category(combined_list, list)
    Rails.logger.info @@removed_items
    Rails.logger.info @@choices
    remove_items(combined_list, @@removed_items)
    Rails.logger.info combined_list
    combined_list
  end
end
