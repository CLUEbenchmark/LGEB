# run decoding
PWD=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
PYTHONPATH=$PWD/../src:$PYTHONPATH
DATA_DIR=$PWD/../data/as/gigaword/
MODEL_RECOVER_PATH=$PWD/../model/fine_tune_model/gigaword/ggw10k_model.bin
EVAL_SPLIT=test
export PYTORCH_PRETRAINED_BERT_CACHE=$PWD/../tmp/bert-cased-pretrained-cache
export CUDA_VISIBLE_DEVICES="2"
# run decoding
python $PWD/../src/biunilm/decode_seq2seq.py --bert_model bert-large-cased \
  --pytorch_pretrained_bert_cache $PYTORCH_PRETRAINED_BERT_CACHE\
  --new_segment_ids --mode s2s --need_score_traces \
  --input_file ${DATA_DIR}/${EVAL_SPLIT}.src --split ${EVAL_SPLIT} --tokenized_input \
  --model_recover_path ${MODEL_RECOVER_PATH} \
  --max_seq_length 192 --max_tgt_length 32 \
  --batch_size 64 --beam_size 5 --length_penalty 0 \
  --forbid_duplicate_ngrams --forbid_ignore_word "."
 #run evaluation
python3 $PWD/../src/gigaword/eval.py --pred ${MODEL_RECOVER_PATH}.${EVAL_SPLIT} \
  --gold ${DATA_DIR}/org_data/${EVAL_SPLIT}.tgt.txt 
