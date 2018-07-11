% The bulk of this task code was written by Arkady Konovalov, PhD (University of Zurich)
% and generously shared on request. I have superficially altered the script to be amenable to
% multiple blocks with different reward structures.

% Please do not share or use this script without the permission of all invovled parties.

function start
global sub pay stim_color_step1 stim_colors_step2 stim_step2_color_select stim_prac_symbol stim_symbol rng_seed
pay = 0;
sub = input('Subject number: '); %keep sub number as a string so we can validate easily below

% shuffle the rng and save the seed
rng('shuffle');
rng_seed = rng;
rng_seed = rng_seed.Seed;

% stimuli sets
symbols = {'b', 'e', 'i', 'inf', 'l', 'n', 'o', 'r', 'ri', 'to', 'u', 'w'};
prac_symbols = {'4pt', '5pt', 'bolt', 'cir', 'pent', 'tri'};
step1_colors = {'white', 'grey', 'dark_grey'};
step2_color_pairs = {'red_blue', 'orange_purple', 'yellow_green'};
step2_color = {'warm', 'cool'};

% create shuffled arrays of each of the symbols and colors
stim_color_step1 = step1_colors(randperm(numel(step1_colors)));
stim_colors_step2 = step2_color_pairs(randperm(numel(step2_color_pairs)));
stim_step2_color_select = step2_color(randperm(numel(step2_color)));

stim_prac_symbol = prac_symbols(randperm(numel(prac_symbols)));
stim_symbol = symbols(randperm(numel(symbols)));


%practice
rng(66);
% tutorial_v4;

% main task
rng(rng_seed);
main_task(2,0); %block is set to 0 to indicate that it is the practice

% randomize the block order
block1 = randi([1,2]); %1 = money, 2 = food
block2 = 3 - block1;
if block1 == 1
  block1_text = 'Food'
  block2_text = 'Money'
else
  block1_text = 'Money'
  block2_text = 'Food'

KbName('UnifyKeyNames');
start_game_key = KbName('S');
exitKeys = KbName('ESCAPE');

%part 1
DrawFormattedText(w,[
    'Please wait while the experimenter prepares' '\n' ...
    'the room for the first version of the game.' '\n\n' ...
    'Version 1 = ' block1_text
    ], 'center','center', [], [], [], [], 1.6);
Screen('Flip',w);

while 1 %wait for response and allow exit if necessesary
  [keyIsDown, ~, keyCode] = KbCheck;
  if keyIsDown && any(keyCode(exitKeys))
      sca; return
  elseif keyIsDown && any(keyCode(start_game_key))
      break
  end
end

main_task(2,block1);

%part 2
DrawFormattedText(w,[
    'Please wait while the experimenter prepares' '\n' ...
    'the space for the first version of the game.' '\n\n' ...
    'Version 1 = ' block2_text
    ], 'center','center', [], [], [], [], 1.6);
Screen('Flip',w);

while 1 %wait for response and allow exit if necessesary
  [keyIsDown, ~, keyCode] = KbCheck;
  if keyIsDown && any(keyCode(exitKeys))
      sca; return
  elseif keyIsDown && any(keyCode(start_game_key))
      break
  end
end

main_task(2,block2);

fprintf('\n\n\n\n\n\n\n\n\n\nYour total earnings (show up fee included) = $ %.2f\n\nThank you for your participation\n\n\n', pay);
end
