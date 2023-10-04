---
author: Chris Pilkington
tags:
- dev
- linux
date: "2022-07-08T23:52:11Z"
id: 539
title: Logging Structured Data From an Application
---

### What is structured data?

Structured data is data formatted in a structured manner so that the sender can clearly communicate to the receiver each field/property/part of each message without confusion or ambiguity about where the message starts/stops, and what each field represents and it’s value.

We usually represent structured data with fields or key value pairs. The data can even be represented in a tree such as in JSON or XML.

### Logging Flavours

[RFC 3164](https://datatracker.ietf.org/doc/html/rfc3164) doesn’t know about structured data:

```bash
<34>Oct 11 22:14:15 mymachine MyApplication: This is the message part
```

[RFC 5424](https://datatracker.ietf.org/doc/html/rfc5424) supports structured data:

```bash
<74>1 2017-07-11T22:14:15.003Z myhostname evntslog - ID47 [exampleSDID@12345 x="y" eventSource="MyApplication" eventID="6789"] This is the message part
```

[systemd journal](https://wiki.archlinux.org/title/Systemd/Journal) supports structured data

### Logging Methods

[syslog(3)](https://man7.org/linux/man-pages/man3/syslog.3.html) designed for RFC 3164, doesn’t know about structured data.  
[logger(1)](https://man7.org/linux/man-pages/man1/logger.1.html) can log with RFC 3164 or RFC 5242, and supports structured data, but just adds it as part of the message field unless you send it to a socket  
[liblogging](https://github.com/rsyslog/liblogging) mentions structured data in the readme, but it hasn’t been implemented  
[sd\_journal\_send/sd\_journal\_sendv](https://www.freedesktop.org/software/systemd/man/sd_journal_print.html) logs to the systemd journal, supports structured data

### ...And the most common method of getting structured data into logs

Adding key/value pairs or JSON to the message part of any logging system. This works in any logging protocol, here is an example of RFC 3164 with JSON in the message part:

```bash
<34>Oct 11 22:14:15 mymachine MyApplication: This message has JSON in it { "x": "y", "age": 123, "flag": true }
```

This works universally for RFC 3164, RFC 5242 and the systemd journal.

With [CEE](https://www.rsyslog.com/json-elasticsearch/):

```bash
<34>Oct 11 22:14:15 mymachine MyApplication: @cee: { "x": "y", "age": 123, "flag": true }
```

Adding JSON to the message part is the lingua franca of logs, it works everywhere, even with old APIs, adding the CEE signature makes the JSON payload easy to identify.

### See Also

<https://rsyslog.adiscon.narkive.com/rrLJiWRs/best-practice-for-an-application-to-get-structured-data-to>  
<https://techblog.bozho.net/the-syslog-hell/>  
<https://sematext.com/blog/what-is-syslog-daemons-message-formats-and-protocols/>  
<https://github.com/systemd/systemd/issues/19251>