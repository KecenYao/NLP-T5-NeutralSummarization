export CUDA=0
export DATA_DIR=./data/naacl2022_lrc_roundup_random_order_probe
export BSZ=8
export ACC_STEP=8
export LR=3e-5
export EPOCH=10 
export CUSTOM_NAME=t5_ft_bsz_16
export MODEL_NAME=t5-large
export OUTPUT_DIR=${PWD}/naacl2022/${MODEL_NAME}.${CUSTOM_NAME}.${LR}.512_250.e${EPOCH}
# Make output directory if it doesn't exist
mkdir -p $OUTPUT_DIR

CUDA_VISIBLE_DEVICES=$CUDA python src/finetune.py \
--data_dir=$DATA_DIR \
--model_name_or_path=$MODEL_NAME \
--learning_rate=${LR} \
--train_batch_size=${BSZ} \
--eval_batch_size=${BSZ} \
--gradient_accumulation_steps ${ACC_STEP} \
--output_dir=$OUTPUT_DIR \
--num_train_epochs=${EPOCH}  \
--gpus=1 \
--do_train "$@" \
--do_predict \
--max_source_length 512 \
--max_target_length 250 \
--val_max_target_length 250 \
--eval_max_gen_length 250 \
--test_max_target_length 250 \
--overwrite_output_dir 