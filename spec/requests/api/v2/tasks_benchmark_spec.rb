require 'rails_helper'
require 'benchmark'

RSpec.describe "V2::Tasks API", type: :request do
  def run_benchmark(description, &block)
    puts "\n#{description}"
    times = []

    100.times do |i|
      time = Benchmark.measure(&block)
      times << time.real * 1000
      print "." if (i + 1) % 10 == 0
    end

    avg_time = times.sum / times.length
    max_time = times.max
    min_time = times.min
    std_dev = calculate_std_dev(times, avg_time)

    puts "\nResults:"
    puts "  Average: #{avg_time.round(2)} ms"
    puts "  Min: #{min_time.round(2)} ms"
    puts "  Max: #{max_time.round(2)} ms"
    puts "  Standard Deviation: #{std_dev.round(2)} ms"

    times
  end

  context "basic task performance" do
    let(:task) { create(:task) }

    it "benchmarks index endpoint with single task" do
      run_benchmark("Benchmarking GET /tasks index with single task") do
        get "/api/v2/tasks/"
        expect(response).to be_successful
      end
    end

    it "benchmarks show endpoint with single task" do
      run_benchmark("Benchmarking GET /tasks/:id show with single task") do
        get "/api/v2/tasks/#{task.id}"
        expect(response).to be_successful
      end
    end
  end

  context "index with multiple tasks" do
    let!(:tasks) { create_list(:task, 100) }

    it "benchmarks index endpoint with 100 tasks" do
      run_benchmark("Benchmarking GET /tasks index with 100 tasks") do
        get "/api/v2/tasks"
        expect(response).to be_successful
      end
    end

    it "benchmarks index endpoint with 100 tasks and associated records" do
      tasks.each do |task|
        create_list(:time_log, 5, task: task)
        create_list(:comment, 5, commentable: task)
      end
      run_benchmark("Benchmarking GET /tasks index with 100 tasks (with 5 time logs and 5 comments each)") do
        get "/api/v2/tasks"
        expect(response).to be_successful
      end
    end
  end

  context "task with time logs" do
    let(:task) { create(:task) }
    let!(:time_logs) { create_list(:time_log, 10, task: task) }

    it "benchmarks show endpoint with time logs included" do
      run_benchmark("Benchmarking GET /tasks/:id show with 10 time logs included") do
        get "/api/v2/tasks/#{task.id}?include_time_logs=true"
        expect(response).to be_successful
      end
    end

    it "benchmarks show endpoint without time logs included" do
      run_benchmark("Benchmarking GET /tasks/:id show with 10 time logs (not included)") do
        get "/api/v2/tasks/#{task.id}"
        expect(response).to be_successful
      end
    end
  end

  context "task with time logs and their comments" do
    let(:task) { create(:task) }
    let!(:time_logs) { create_list(:time_log, 10, task: task) }

    before do
      time_logs.each do |time_log|
        create_list(:comment, 5, commentable: time_log)
      end
    end

    it "benchmarks show endpoint with time logs included" do
      run_benchmark("Benchmarking GET /tasks/:id show with 10 time logs (5 comments each) included") do
        get "/api/v2/tasks/#{task.id}?include_time_logs=true"
        expect(response).to be_successful
      end
    end

    it "benchmarks show endpoint without time logs included" do
      run_benchmark("Benchmarking GET /tasks/:id show with 10 time logs (5 comments each) not included") do
        get "/api/v2/tasks/#{task.id}"
        expect(response).to be_successful
      end
    end
  end

  context "task with comments" do
    let(:task) { create(:task) }
    let!(:comments) { create_list(:comment, 10, commentable: task) }

    it "benchmarks show endpoint with comments included" do
      run_benchmark("Benchmarking GET /tasks/:id show with 10 comments included") do
        get "/api/v2/tasks/#{task.id}?include_comments=true"
        expect(response).to be_successful
      end
    end

    it "benchmarks show endpoint without comments included" do
      run_benchmark("Benchmarking GET /tasks/:id show with 10 comments (not included)") do
        get "/api/v2/tasks/#{task.id}"
        expect(response).to be_successful
      end
    end
  end

  context "task with both time logs and comments" do
    let(:task) { create(:task) }
    let!(:time_logs) { create_list(:time_log, 10, task: task) }
    let!(:comments) { create_list(:comment, 10, commentable: task) }

    it "benchmarks show endpoint with both includes" do
      run_benchmark("Benchmarking GET /tasks/:id show with 10 time logs and 10 comments included") do
        get "/api/v2/tasks/#{task.id}?include_time_logs=true&include_comments=true"
        expect(response).to be_successful
      end
    end

    it "benchmarks show endpoint without any includes" do
      run_benchmark("Benchmarking GET /tasks/:id show with 10 time logs and 10 comments (not included)") do
        get "/api/v2/tasks/#{task.id}"
        expect(response).to be_successful
      end
    end
  end

  context "task with large dataset" do
    let(:task) { create(:task) }
    let!(:time_logs) { create_list(:time_log, 100, task: task) }
    let!(:comments) { create_list(:comment, 50, commentable: task) }

    it "benchmarks show endpoint with time logs included" do
      run_benchmark("Benchmarking GET /tasks/:id show with 100 time logs included") do
        get "/api/v2/tasks/#{task.id}?include_time_logs=true"
        expect(response).to be_successful
      end
    end

    it "benchmarks show endpoint with comments included" do
      run_benchmark("Benchmarking GET /tasks/:id show with 50 comments included") do
        get "/api/v2/tasks/#{task.id}?include_comments=true"
        expect(response).to be_successful
      end
    end

    it "benchmarks show endpoint with both includes" do
      run_benchmark("Benchmarking GET /tasks/:id show with 100 time logs and 50 comments included") do
        get "/api/v2/tasks/#{task.id}?include_time_logs=true&include_comments=true"
        expect(response).to be_successful
      end
    end

    it "benchmarks show endpoint without any includes" do
      run_benchmark("Benchmarking GET /tasks/:id show with 100 time logs and 50 comments (not included)") do
        get "/api/v2/tasks/#{task.id}"
        expect(response).to be_successful
      end
    end
  end

  private

  def calculate_std_dev(times, mean)
    sum_squared_diff = times.sum { |time| (time - mean) ** 2 }
    Math.sqrt(sum_squared_diff / times.length)
  end
end
