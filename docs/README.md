---
layout: home
permalink: index.html

# Please update this with your repository name and title
repository-name: eYY-4yp-project-template
title:
---

[comment]: # "This is the standard layout for the project, but you can clean this and use your own template"

# Hardware-Cache-Switching-with-Operating-System-Context-Switches

#### Team

- E/16/332, Randika Viraj, [email](mailto:e16332@eng.pdn.ac.lk)
- E/16/222, Wshva Madushnaka, [email](mailto:e16222@eng.pdn.ac.lk)

#### Supervisors

- Dr.Isuru Nawinne, [email](mailto:isurunawinne@eng.pdn.ac.lk)
- Dr.Mahanama Wickramasingh, [email](mailto:mahanamaw@eng.pdn.ac.lk)
- Prof.Roshan Ragel, [email](mailto:roshanr@eng.pdn.ac.lk)
- Dr.Haris Javaid, [email](mailto:haris.javaid@amd.com)

#### Table of content

1. [Abstract](#abstract)
2. [Related works](#related-works)
3. [Methodology](#methodology)
4. [Experiment Setup and Implementation](#experiment-setup-and-implementation)
5. [Results and Analysis](#results-and-analysis)
6. [Conclusion](#conclusion)
7. [Publications](#publications)
8. [Links](#links)

---

This is a sample image, to show how to add images to your page. To learn more options, please refer [this](https://projects.ce.pdn.ac.lk/docs/faq/how-to-add-an-image/)

![Sample Image](./images/sample.png)

## Abstract
Caches are used to improve the speed and efficiency of memory access. However, the optimal cache configuration depends on the application's memory access patterns. When a context switch occurs, the cache data of the current thread must be flushed, and new data from the new thread loaded, which can increase memory access time and energy usage.

To improve cache performance, various techniques and methods have been developed. We propose cache partitioning, which divides the cache into multiple partitions. The program can choose the most suitable cache at runtime by executing special instructions. This method reduces the interference between the cache contents of different processes that led to minimizing the context switch overhead.

## Related works
Due to the memory access pattern difference between the programs and the power consumption of the embedded systems finding the best or nearly the best cache configuration becomes important. Varys' method has been proposed by many authors. Some of the methods consider only one particular cache parameter while some method considers all the cache parameters. 
A.Patel et al.(2006) propose an improved indexing schema for direct-mapped caches. This method decreases the number of conflict misses significantly by using application-specific data. Simply choose a subset of the address bit which can reduce the number of conflicts misses. This method only considers direct map cache. The method enables the best cache indexing to meet a specific application according to a reconfigurable bit selector that can be configured at runtime. Albonsei et al.(1999) propose a method called selective cache ways with a minor hardware modification that provides the ability to enable a subset of cache ways when the demand increases. When great performance is necessary, all cache ways are enabled. However, when cache demands are lower, only a portion of the ways are enabled. In this method, it reduces the power consumption with on-demand activation of the cache way. 

Memory data in the set associativity cache is not used across the sets. As a result of the cache's underutilization, performance suffers. Rolan et al.(2009) propose a method called “Set balancing” for balancing the set’s pressure. Set Balancing Cache or SBC moves lines from sets with high local miss rates to sets with underutilized lines, where they can subsequently be found. Zhang et al.(2003) propose new cache architecture that can be configured by software. By adjusting a few bits in a configuration register, the cache can be configured in software to be directly mapped or set associative while still utilizing the entire cache's capacity.

Gordon-Ross et al.(2007) introduce non-intrusive on-chip cache-tuning hardware modules that can predict the accurate best configuration for an executing program. Using this technique, addresses produced by a microprocessor are silently gathered. The ideal cache setup is then determined by further analysis of those data. The cache is then instantaneously updated to the most ideal configuration, never looking at inferior configurations. As a result, there is less energy usage and performance overhead, enabling more frequent cache adjustment. Zhang et al. (2004), propose a self-tuning cache architecture that adjusts its configuration based on program behavior to optimize performance. The authors use a feedback loop to adaptively adjust the cache parameters, such as cache size and associativity, to minimize the number of cache misses. Gordon-Ross and Vahid (2007), build on the previous work of Zhang et al. by proposing a configurable cache architecture that allows the cache to be reconfigured dynamically based on program behavior. The authors use a profiling technique to identify the most frequently accessed memory blocks and adjust the cache configuration accordingly.

## Methodology

## Experiment Setup and Implementation

## Results and Analysis

## Conclusion

## Publications
1. [Semester 7 report](./)
2. [Semester 7 slides](./)
3. [Semester 8 report](./)
4. [Semester 8 slides](./)
5. Author 1, Author 2 and Author 3 "Research paper title" (2021). [PDF](./).


## Links

[//]: # ( NOTE: EDIT THIS LINKS WITH YOUR REPO DETAILS )

- [Project Repository](https://github.com/cepdnaclk/repository-name)
- [Project Page](https://cepdnaclk.github.io/repository-name)
- [Department of Computer Engineering](http://www.ce.pdn.ac.lk/)
- [University of Peradeniya](https://eng.pdn.ac.lk/)

[//]: # "Please refer this to learn more about Markdown syntax"
[//]: # "https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet"
