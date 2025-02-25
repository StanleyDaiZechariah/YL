import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import '../utils';
import { Log } from '@abner/log';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    Log.info('Ability onCreate')
  }

  onDestroy(): void {
    Log.info('Ability onDestroy')
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    Log.info('Ability onWindowStageCreate')

    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        Log.error('Failed to load the content.')
        return;
      }
      Log.info('Succeeded in loading the content.')
    });
  }

  onWindowStageDestroy(): void {
    Log.info('Ability onWindowStageDestroy')
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    Log.info('Ability onForeground')
  }

  onBackground(): void {
    Log.info('Ability onBackground')
  }
}
