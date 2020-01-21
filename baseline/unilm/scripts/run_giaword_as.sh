# run fine-tuning
PWD=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
PYTHONPATH=$PWD/../src:$PYTHONPATH
DATA_DIR=$PWD/../data/as/gigaword
OUTPUT_DIR=$PWD/../fine_tune_model/as/gigaword
if [ -d $OUTPUT_DIR ]; then
  mkdir -p $OUTPUT_DIR
fi
MODEL_RECOVER_PATH=$PWD/../model/unilmv1-large-cased.bin
export PYTORCH_PRETRAINED_BERT_CACHE=$PWD/../tmp/bert-cased-pretrained-cache
export CUDA_VISIBLE_DEVICES=1,2
python $PWD/../src/biunilm/run_seq2seq.py --do_train --num_workers 0 \
  --pytorch_pretrained_bert_cache $PYTORCH_PRETRAINED_BERT_CACHE \
  --bert_model bert-large-cased --new_segment_ids --tokenized_input \
  --data_dir ${DATA_DIR} --src_file train.src.10k --tgt_file train.tgt.10k \
  --output_dir ${OUTPUT_DIR}/bert_save \
  --log_dir ${OUTPUT_DIR}/bert_log \
  --model_recover_path ${MODEL_RECOVER_PATH} \
  --max_seq_length 192 --max_position_embeddings 192 \
  --trunc_seg a --always_truncate_tail --max_len_b 64 \
  --mask_prob 0.7 --max_pred 64 \
  --train_batch_size 32 --gradient_accumulation_steps 1 \
  --learning_rate 0.00001 --warmup_proportion 0.1 --label_smoothing 0.1 \
  --num_train_epochs 30
