# run fine-tuning
PWD=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
PYTHONPATH=$PWD/../src:$PYTHONPATH
DATA_DIR=$PWD/../data/qg/squad/train
OUTPUT_DIR=$PWD/../fine_tune_model/qg/squad/
if [ -d $OUTPUT_DIR ]; then
  mkdir -p $OUTPUT_DIR
fi

MODEL_RECOVER_PATH=$PWD/../model/unilmv1-large-cased.bin
export PYTORCH_PRETRAINED_BERT_CACHE=$PWD/../tmp/bert-cased-pretrained-cache
export CUDA_VISIBLE_DEVICES=1,2
python $PWD/../src/biunilm/run_seq2seq.py --do_train --num_workers 0 \
  --pytorch_pretrained_bert_cache $PYTORCH_PRETRAINED_BERT_CACHE \
  --bert_model bert-large-cased --new_segment_ids --tokenized_input \
  --data_dir ${DATA_DIR} --src_file train.pa.tok.txt --tgt_file train.q.tok.txt \
  --output_dir ${OUTPUT_DIR}/bert_save \
  --log_dir ${OUTPUT_DIR}/bert_log \
  --model_recover_path ${MODEL_RECOVER_PATH} \
  --max_seq_length 512 --max_position_embeddings 512 \
  --mask_prob 0.7 --max_pred 48 \
  --train_batch_size 16 --gradient_accumulation_steps 2 \
  --learning_rate 0.00002 --warmup_proportion 0.1 --label_smoothing 0.1 \
  --num_train_epochs 10
