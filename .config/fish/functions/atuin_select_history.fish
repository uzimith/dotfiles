function atuin_select_history
    # sm は default モードから起動するが、確定後は insert モードに戻るため
    # atuin 側の keymap も insert として扱わせる
    set -l fish_bind_mode insert
    _atuin_search
end
