---
author: Chris Pilkington
tags:
- c++
- dev
date: "2017-02-26T23:16:08Z"
id: 477
title: Stop Watch and Time Out Classes
---

I have a passing interest in stop watch and time out type classes. Keeping track of elapsed time, remaining time. They are very basic classes, but I find them interesting.

**[GetTimeMS function](https://github.com/pilkch/tests/blob/master/stopwatch/main.cpp#L15)**

The stop watch and timer classes use this function to get the system time, we actually return the system time minus the application start time to get a time relative to the application start time, starting at 0. This is not necessary, return the system time is fine, returning the time the application is running is usually just easier to think about than the time since 1970, which is kind of arbitrary.  
This function uses milliseconds, if this is not enough, we can easily switch to nanoseconds.

```cpp
typedef uint64_t durationms_t;

// Get the time since epoch in milliseconds
durationms_t GetTimeMS()
{
  static const std::chrono::system_clock::time_point start = std::chrono::system_clock::now();

  const std::chrono::system_clock::time_point now = std::chrono::system_clock::now();
  return std::chrono::duration_cast<:chrono::milliseconds>(now - start).count();
}
```

**[Stop watch class](https://github.com/pilkch/tests/blob/master/stopwatch/main.cpp#L33)**

Provides start, stop, reset and we can get the total duration.

```cpp
class cStopWatch
{
public:
  cStopWatch();
 
  void Start();
  void Stop();
  void Reset();
 
  durationms_t GetTotalDurationMS() const;
 
private:
  bool running;
  durationms_t started;
  durationms_t totalDuration;
};
 
cStopWatch::cStopWatch() :
  running(false),
  started(0),
  totalDuration(0)
{
}
 
void cStopWatch::Start()
{
  assert(!running);
 
  // Started our stop watch
  started = GetTimeMS();
 
  running = true;
}
 
void cStopWatch::Stop()
{
  assert(running);
 
  // Get the time now
  const durationms_t now = GetTimeMS();
 
  // Add the duration for this period
  totalDuration += now - started;
 
  // Reset our start time
  started = 0;
 
  running = false;
}
 
void cStopWatch::Reset()
{
  started = 0;
  totalDuration = 0;
 
  running = false;
}
 
durationms_t cStopWatch::GetTotalDurationMS() const
{
  if (running) {
    // Get the time now
    const durationms_t now = GetTimeMS();
 
    // Return the previous duration plus the duration of the current period
    return totalDuration + (now - started);
  }
 
  return totalDuration;
}
```

**Example usage**

```cpp
cStopWatch stopWatch;

// Start the stop watch
stopWatch.Start();

// Sleep for 1 second
const uint64_t timeout_ms = 1000;
::usleep(1000 * timeout_ms);

// Stop the stop watch
stopWatch.Stop();

// We have now waited for at least 1 second
std::cout<<"Stop watch time: "<<stopWatch.GetTotalDurationMS()<<" ms"<<std::endl;
```

**[Time out class](https://github.com/pilkch/tests/blob/master/stopwatch/main.cpp#L112)**

Allows us to get the time remaining, check if the time out has expired and reset the time out.

```cpp
class cTimeOut {
public:
  explicit cTimeOut(durationms_t timeout);

  void Reset();

  bool IsExpired() const;

  durationms_t GetRemainingMS() const;

private:
  const durationms_t timeout;
  durationms_t startTime;
};

cTimeOut::cTimeOut(durationms_t _timeout) :
  timeout(_timeout),
  startTime(GetTimeMS())
{
}

void cTimeOut::Reset()
{
  startTime = GetTimeMS();
}

bool cTimeOut::IsExpired() const
{
  return ((GetTimeMS() - startTime) > timeout);
}

durationms_t cTimeOut::GetRemainingMS() const
{
  // Get the total time this timeout uhas been running for so far
  const int64_t duration = int64_t(GetTimeMS()) - int64_t(startTime);

  // Calculate the remaining time
  const int64_t remaining = (int64_t(timeout) - duration);

  // Return the remaining time if there is any left
  return (remaining >= 0) ? remaining : 0;
}
```

**Example usage**

```cpp
// Create a 5 second time out
cTimeOut timeout(5000);

// Wait until the time out is expired
while (!timeout.IsExpired()) {
  std::cout<<"Waiting..."<<std::endl;

  // Sleep for 1 second
  const uint64_t timeout_ms = 1000;
  ::usleep(1000 * timeout_ms);
}

std::cout<<"Time out reached"<<std::endl;
```
