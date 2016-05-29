configureIM;

% make the target sequence
noiseSeq=mkStimSeqRand(4,8);

% make the stimulus
%figure;
fig=figure(2);
set(fig,'Name','Imagined Movement','color',[0 0 0],'menubar','none','toolbar','none','doublebuffer','on');
clf;
ax=axes('position',[0.025 0.025 .95 .95],'units','normalized','visible','off','box','off',...
        'xtick',[],'xticklabelmode','manual','ytick',[],'yticklabelmode','manual',...
        'color',[0 0 0],'DrawMode','fast','nextplot','replacechildren',...
        'xlim',[-1.5 1.5],'ylim',[-1.5 1.5],'Ydir','normal');

    
h=[];
% draw stimulus: MI task arrow (left)
h(1,1) = annotation(gcf,'arrow',[0.35 0.25],[0.5 0.5],'HeadLength',30,'HeadWidth',40,...
    'HeadStyle','plain','LineWidth',4,'Color',[1 1 1]);
% draw stimulus: MI task arrow (right)
h(1,2) = annotation(gcf,'arrow',[0.65 0.75],[0.5 0.5],'HeadLength',30,'HeadWidth',40,...
    'HeadStyle','plain','LineWidth',4,'Color',[1 1 1]);
% draw stimulus: noise (eye movement)
h(1,3) = annotation(gcf,'ellipse',...
    [0.425 0.45 0.15 0.1],'LineWidth',4,'Color',[0.8 0.1 0]);
h(2,3) = annotation(gcf,'ellipse',...
    [0.4625 0.45 0.075 0.1],'LineWidth',4,'FaceColor',[0.8 0.1 0], 'Color',[0.8 0.1 0]);
% draw stimulus: noise (muscle activity)
h(1,4) = annotation(gcf,'ellipse',...
    [0.425 0.45 0.15 0.1],'LineWidth',4,'Color',[0.8 0.1 0]);
h(2,4) = annotation(gcf,'line',[0.425 0.575],[0.5 0.5],'LineWidth',4,'Color',[0.8 0.1 0]);
% draw stimulus: noise (eyes shut)
h(1,5) = annotation(gcf,'ellipse',...
    [0.425 0.45 0.15 0.1],'LineWidth',4,'FaceColor',[0.8 0.1 0],'Color',[0.8 0.1 0]);
% draw stimulus: fixation cross
h(1,6) = line([-0.2 0.2], [0 0],'Color','w','LineWidth',4);
h(2,6) = line([0 0], [-0.2 0.2],'Color','w','LineWidth',4);
% draw stimulus: MI feedback arrow (left)
h(1,7) = annotation(gcf,'arrow',[0.35 0.25],[0.5 0.5],'HeadLength',30,'HeadWidth',40,...
    'HeadStyle','plain','LineWidth',4,'Color',[0 0 1]);
% draw stimulus: MI feedback arrow (right)
h(2,7) = annotation(gcf,'arrow',[0.65 0.75],[0.5 0.5],'HeadLength',30,'HeadWidth',40,...
    'HeadStyle','plain','LineWidth',4,'Color',[0 0 1]);
% draw stimulus: fixate dots
% Middle
h(5,8) = annotation(gcf,'ellipse',[0.49 0.49 0.02 0.02],'LineWidth',4,'FaceColor',[0.8 0.1 0],'Color',[0.8 0.1 0]);
% Left Bottom
h(1,8) = annotation(gcf,'ellipse',[0.09 0.09 0.02 0.02],'LineWidth',4,'FaceColor',[0.8 0.1 0],'Color',[0.8 0.1 0]);
% Left Up
h(2,8) = annotation(gcf,'ellipse',[0.09 0.89 0.02 0.02],'LineWidth',4,'FaceColor',[0.8 0.1 0],'Color',[0.8 0.1 0]);
% Right Bottom
h(3,8) = annotation(gcf,'ellipse',[0.89 0.09 0.02 0.02],'LineWidth',4,'FaceColor',[0.8 0.1 0],'Color',[0.8 0.1 0]);
% Right Up
h(4,8) = annotation(gcf,'ellipse',[0.89 0.89 0.02 0.02],'LineWidth',4,'FaceColor',[0.8 0.1 0],'Color',[0.8 0.1 0]);

set(gca,'visible','off');
%Create a text object with no text in it, center it, set font and color
set(fig,'Units','pixel');wSize=get(fig,'position');set(fig,'units','normalized');% win size in pixels
txthdl = text(mean(get(ax,'xlim')),mean(get(ax,'ylim')),' ',...
				  'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle',...
				  'fontunits','pixel','fontsize',.05*wSize(4),...
				  'color',[0.75 0.75 0.75],'visible','off');
              
set(h(:),'visible','off');               
set(txthdl,'string', 'Click mouse when ready', 'visible', 'on'); drawnow;
waitforbuttonpress;
set(txthdl,'visible', 'off'); drawnow;              

set(h(5,8),'visible','on');drawnow;
sendEvent('stimulus.baseline.eyesmove','start');
sleepSec(trialDuration);
sendEvent('stimulus.baseline.eyesmove','end');
set(h(:),'visible','off');drawnow;

for si=1:8;
    set(h((noiseSeq(:,si)>0),8),'visible','on');drawnow;
    sendEvent('stimulus.baseline.eyesmove','start');
    sleepSec(trialDuration);
    sendEvent('stimulus.baseline.eyesmove','end');
    set(h(:),'visible','off'); drawnow;
end

set(h(5,8),'visible','on');drawnow;
sendEvent('stimulus.baseline.eyesmove','start');
sleepSec(trialDuration);
sendEvent('stimulus.baseline.eyesmove','end');
set(h(:),'visible','off');drawnow;

              
set(h(:),'visible','off');              
set(txthdl,'string', 'Click mouse when ready', 'visible', 'on'); drawnow;
waitforbuttonpress;
set(txthdl,'visible', 'off'); drawnow;

% 30 sec of fixation
set(h(1,6),'visible','on');
set(h(2,6),'visible','on');drawnow;
sendEvent('stimulus.baseline.eyesopen','start');
sleepSec(eyesDuration);
sendEvent('stimulus.baseline.eyesopen','end');
set(h(:),'visible','off');

% 30 sec of eyes closed
set(h(1,5),'visible','on'); drawnow;
sendEvent('stimulus.baseline.eyesclosed','start');
sleepSec(eyesDuration);
sendEvent('stimulus.baseline.eyesclosed','end');
sound(1);
set(h(:),'visible','off');

% eye blinking 15 sec
set(h(1,3),'visible','on');
set(h(2,3),'visible','on');drawnow;
sendEvent('artifact.blink','start');
sleepSec(artifactDuration);
sendEvent('artifact.blink','end');
set(h(:),'visible','off');

% jaw clench
set(h(1,4),'visible','on');
set(h(2,4),'visible','on');drawnow;
sendEvent('artifact.jaw','start');
sleepSec(artifactDuration);
sendEvent('artifact.jaw','end');
set(h(:),'visible','off');

% eye blinking
set(h(1,3),'visible','on');
set(h(2,3),'visible','on');drawnow;
sendEvent('artifact.blink','start');
sleepSec(artifactDuration);
sendEvent('artifact.blink','end');
set(h(:),'visible','off');

% jaw clench
set(h(1,4),'visible','on');
set(h(2,4),'visible','on');drawnow;
sendEvent('artifact.jaw','start');
sleepSec(artifactDuration);
sendEvent('artifact.jaw','end');
set(h(:),'visible','off');

% 30 sec of fixation
set(h(1,6),'visible','on');
set(h(2,6),'visible','on');drawnow;
sendEvent('stimulus.baseline.eyesopen','start');
sleepSec(eyesDuration);
sendEvent('stimulus.baseline.eyesopen','end');
set(h(:),'visible','off');

if ( ishandle(fig) ) % thanks message
set(txthdl,'string',{'That ends the training phase.','Thanks for your patience'}, 'visible', 'on', 'color',[0 1 0]);
pause(3);
end