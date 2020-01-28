# LGEB
LGEB: Benchmark of Language Generation Evaluation

目前支持的任务有Abstractive Summarization和Question Generation

用法：
  1. 首先将数据下载到对应文件夹  
  将tmp/data/model/解压到unilm目录下，下载链接如下：   
  ```https://pan.baidu.com/s/1nr9Xet0tx7bCI5UVICX1Pg```
  2. 执行脚本  
   ```cd LGEB/baseline/unilm/scripts ```  
  训练: ```run_giaword_as.sh``` / ```run_squad_qg.sh```  
  评估: ```run_giaword_as_eval.sh``` / ```run_squad_qg_eval.sh``` 
 
目前效果如下：  

（https://github.com/microsoft/unilm 保持一致）
### Abstractive Summarization - [Gigaword](https://github.com/harvardnlp/sent-summary) (10K) 

The data can be downloaded from [here](https://drive.google.com/open?id=1USoQ8lJgN8kAWnUnRrupMGrPMLlDVqlV). 

| Model                                                               | ROUGE-1   | ROUGE-2   | ROUGE-L   |
| ------------------------------------------------------------------- | --------- | --------- | --------- |
| [Transformer](http://proceedings.mlr.press/v97/song19d/song19d.pdf) | 10.97     | 2.23      | 10.42     |
| **UniLM**                                                           | **34.21** | **15.28** | **31.54** |

### Question Generation - [SQuAD](https://arxiv.org/abs/1806.03822) 

Our processed data can be downloaded from [here](https://drive.google.com/open?id=11E3Ij-ctbRUTIQjueresZpoVzLMPlVUZ).

| Model                                                              | BLEU-4    | METEOR    | ROUGE-L   |
| ------------------------------------------------------------------ | --------- | --------- | --------- |
| [(Du and Cardie, 2018)](https://www.aclweb.org/anthology/P18-1177) | 15.16     | 19.12     | -         |
| [(Zhang and Bansal, 2019)](https://arxiv.org/pdf/1909.06356.pdf)   | 18.37     | 22.65     | 46.68     |
| **UniLM**                                                          | **22.78** | **25.49** | **51.57** |

Note: If we directly use the tokenized references provided by [Du et al. (2017)](https://arxiv.org/pdf/1705.00106.pdf), the results are (22.17 BLEU-4 / 25.47 METEOR / 51.53 ROUGE-L) on the [raw data split](https://github.com/xinyadu/nqg/tree/master/data)
