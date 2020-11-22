# frozen_string_literal: true

json.array!(@tasks) do |task|
  json.extract! task, :id, :name, :completed
  json.url list_task_path(@list, task, format: :json)
end
