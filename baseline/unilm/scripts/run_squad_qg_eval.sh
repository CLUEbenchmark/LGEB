
export CUDA_VISIBLE_DEVICES="2"
PWD=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
PYTHONPATH=$PWD/../src:$PYTHONPATH
DATA_DIR=$PWD/../data/qg/squad/test
MODEL_RECOVER_PATH=$PWD/../model/fine_tune_model/squad/qg_model.bin
EVAL_SPLIT=test
export PYTORCH_PRETRAINED_BERT_CACHE=$PWD/../tmp/bert-cased-pretrained-cache
# run decoding
python3 $PWD/../src/biunilm/decode_seq2seq.py --bert_model bert-large-cased \
  --pytorch_pretrained_bert_cache $PYTORCH_PRETRAINED_BERT_CACHE\
  --output_file $DATA_DIR/output/qg.test.output.txt \
  --new_segment_ids --mode s2s \
  --input_file ${DATA_DIR}/test.pa.tok.txt --split ${EVAL_SPLIT} --tokenized_input \
  --model_recover_path ${MODEL_RECOVER_PATH} \
  --max_seq_length 512 --max_tgt_length 48 \
  --batch_size 16 --beam_size 1 --length_penalty 0
# run evaluation using our tokenized data as reference
python3 $PWD/../src/qg/eval_on_unilm_tokenized_ref.py \
  --src_file $DATA_DIR/test.pa.txt \
  --tgt_file $DATA_DIR/test.q.tok.txt  \
  --out_file $DATA_DIR/output/qg.test.output.txt
# run evaluation using tokenized data of Du et al. (2017) as reference
python3 $PWD/../src/qg/eval.py  \
  --src_file $DATA_DIR/test.pa.txt \
  --tgt_file $DATA_DIR/../nqg_processed_data/tgt-test.txt \
  --out_file $DATA_DIR/output/qg.test.output.txt
