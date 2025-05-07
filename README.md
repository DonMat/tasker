# Tasker API

This document presents a detailed performance analysis of different JSON serialization libraries used in the Tasker API.

## Benchmark your own
Just use **benchmarking** branch to do your own test.


JBuilder:
- rspec spec/requests/tasks_benchmark_spec.rb 

Active Model Serializers:
- rspec spec/requests/v2/tasks_benchmark_spec.rb 

Grape:
- rspec spec/requests/v2/tasks_benchmark_spec.rb 

Grape + Active Model Serializers:
- rspec spec/requests/v3/tasks_benchmark_spec.rb 

## Application domain model
![DB relations](https://github.com/DonMat/tasker/blob/main/img/db.png)



## Performance Summary

### Best Performers by Operation Type

| Operation Type | Best Performer | Average Response Time |
|----------------|----------------|----------------------|
| GET Single Task| **Grape** | 4.59ms |
| POST Task | **Grape + AMS** | 8.17ms |
| GET List 100 Tasks  | **JBuilder** | 22.04ms |
| POST Create 100 Tasks | **Grape** | 756.12ms |
| GET Task with assotiations | **Grape** | 111.63ms |


## Detailed Performance Results

### GET Operations

| Operation | Grape | JBuilder | Grape + AMS | AMS |
|-----------|-------|----------|-------------|-----|
| **GET /tasks (single task)** | **4.59ms** | 8.10ms | 5.26ms | 5.78ms |
| **GET /tasks/:id (single task)** | **4.43ms** | 5.35ms | 4.63ms | 5.27ms |
| **GET /tasks (100 tasks)** | 27.89ms | **22.04ms** | 25.52ms | 25.79ms |
| **GET /tasks (100 tasks with 5 time logs and 5 comments)** | 24.74ms | **21.07ms** | 25.28ms | 25.71ms |
| **GET /tasks/:id (10 time logs included)** | **14.65ms** | 17.73ms | 16.60ms | 17.68ms |
| **GET /tasks/:id (10 time logs not included)** | **3.95ms** | 4.61ms | 4.07ms | 4.86ms |
| **GET /tasks/:id (10 time logs with 5 comments included)** | **13.25ms** | 14.95ms | 16.49ms | 16.89ms |
| **GET /tasks/:id (10 time logs with 5 comments not included)** | **3.88ms** | 4.95ms | 4.09ms | 4.87ms |
| **GET /tasks/:id (10 comments included)** | **13.48ms** | 16.84ms | 16.00ms | 16.81ms |
| **GET /tasks/:id (10 comments not included)** | **3.83ms** | 4.67ms | 4.16ms | 4.81ms |
| **GET /tasks/:id (10 time logs + 10 comments included)** | **21.96ms** | 25.54ms | 26.77ms | 27.77ms |
| **GET /tasks/:id (10 time logs + 10 comments not included)** | **3.88ms** | 4.55ms | 4.09ms | 4.87ms |
| **GET /tasks/:id (100 time logs included)** | **78.98ms** | 87.81ms | 97.94ms | 94.46ms |
| **GET /tasks/:id (50 comments included)** | **39.44ms** | 48.20ms | 47.26ms | 50.00ms |
| **GET /tasks/:id (100 time logs + 50 comments included)** | **111.63ms** | 128.80ms | 138.08ms | 139.59ms |
| **GET /tasks/:id (100 time logs + 50 comments not included)** | **3.99ms** | 4.55ms | 4.22ms | 4.94ms |

### POST Operations

| Operation | Grape | JBuilder | Grape + AMS | AMS |
|-----------|-------|----------|-------------|-----|
| **POST /tasks (single task)** | 9.66ms | 15.60ms | 8.17ms | **9.11ms** |
| **POST /tasks (10 tasks)** | **74.88ms** | 86.13ms | 77.73ms | 80.44ms |
| **POST /tasks (100 tasks)** | **756.12ms** | 968.70ms | 833.22ms | 809.31ms |



## Overall Performance Analysis

1. **Grape** shows the best performance in most GET operations, especially for single tasks and complex queries with associations.
2. **JBuilder** performs best for bulk GET operations with 100 tasks.
3. **Grape + AMS** shows competitive performance in POST operations, particularly for single task creation.
4. **AMS** demonstrates consistent performance across all operations but doesn't lead in any specific category.
