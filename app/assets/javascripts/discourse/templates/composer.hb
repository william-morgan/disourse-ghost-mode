{{#if visible}}
<div class='contents'>

  {{#if currentUser.staff}}
    {{#popup-menu visible=optionsVisible hide="hideOptions" title="composer.options"}}
      <li>
        {{d-button action="toggleWhisper" icon="eye-slash" label="composer.toggle_whisper"}}
      </li>
    {{/popup-menu}}
  {{/if}}

  {{render "composer-messages"}}
  <div class='control'>

    {{#if site.mobileView}}
    <a href class='toggle-toolbar' {{action "toggleToolbar" bubbles=false}}></a>
    {{/if}}
    <a href class='toggler' {{action "toggle" bubbles=false}} title={{i18n 'composer.toggler'}}></a>

    {{#if model.viewOpen}}
      <div class='control-row reply-area'>
        <div class='composer-fields'>
          {{plugin-outlet "composer-open"}}

          <div class='reply-to'>
            {{{model.actionTitle}}}
            {{#unless site.mobileView}}
            {{#if model.whisper}}
              <span class='whisper'>({{i18n "composer.whisper"}})</span>
            {{/if}}
            {{/unless}}

            {{#if canEdit}}
              {{#if showEditReason}}
                <div class="edit-reason-input">
                  {{text-field value=editReason tabindex="7" id="edit-reason" maxlength="255" placeholderKey="composer.edit_reason_placeholder"}}
                </div>
              {{else}}
                <a {{action "displayEditReason"}} class="display-edit-reason">{{i18n 'composer.show_edit_reason'}}</a>
              {{/if}}
            {{/if}}
          </div>

          {{#if model.canEditTitle}}
            <div class='form-element clearfix'>
              {{#if model.creatingPrivateMessage}}
                {{user-selector topicId=controller.controllers.topic.model.id
                                excludeCurrentUser="true"
                                id="private-message-users"
                                includeMentionableGroups="true"
                                class="span8"
                                placeholderKey="composer.users_placeholder"
                                tabindex="1"
                                usernames=model.targetUsernames
                                hasGroups=model.hasTargetGroups
                                }}
                {{#if showWarning}}
                  <div class='add-warning'>
                    <label>
                      {{input type="checkbox" checked=model.isWarning tabindex="3"}}
                      {{i18n "composer.add_warning"}}
                    </label>
                  </div>
                {{/if}}
              {{/if}}

              {{composer-title composer=model lastValidatedAt=lastValidatedAt}}

              {{#if model.showCategoryChooser}}
                <div class="category-input">
                  {{category-chooser valueAttribute="id" value=model.categoryId scopedCategoryId=scopedCategoryId tabindex="3"}}
                  {{popup-input-tip validation=categoryValidation}}
                </div>
                {{#if model.archetype.hasOptions}}
                  <button class='btn' {{action "showOptions"}}>{{i18n 'topic.options'}}</button>
                {{/if}}
                {{render "additional-composer-buttons" model}}
              {{/if}}

            </div>
<label class="switch">
  <input id="ghost_mode_switch" type="checkbox">
  <div class="slider round"></div>
</label>
          {{/if}}

          {{plugin-outlet "composer-fields"}}
        </div>

        {{composer-editor topic=topic
                          composer=model
                          lastValidatedAt=lastValidatedAt
                          canWhisper=canWhisper
                          draftStatus=model.draftStatus
                          isUploading=isUploading
                          groupsMentioned="groupsMentioned"
                          importQuote="importQuote"
                          showOptions="showOptions"
                          showToolbar=showToolbar
                          showUploadSelector="showUploadSelector"}}

        {{#if currentUser}}
          <div class='submit-panel'>
            {{plugin-outlet "composer-fields-below"}}
            <button {{action "save"}} tabindex="5" {{bind-attr class=":btn :btn-primary :create disableSubmit:disabled"}} title="{{i18n 'composer.title'}}">{{{model.saveIcon}}}{{model.saveText}}</button>
            <a href {{action "cancel"}} class='cancel' tabindex="6">{{i18n 'cancel'}}</a>

            {{#if site.mobileView}}
            {{#if model.whisper}}
            <span class='whisper'><i class='fa fa-eye-slash'></i></span>
            {{/if}}
            {{/if}}
          </div>
        {{/if}}
      </div>
    {{else}}
      <div class='row'>
        <div class='span24'>
          <div class='saving-text'>
            {{#if model.createdPost}}
              {{i18n 'composer.saved'}} <a class='permalink' href="{{unbound createdPost.url}}" {{action "viewNewReply"}}>{{i18n 'composer.view_new_post'}}</a>
            {{else}}
              {{i18n 'composer.saving'}} {{loading-spinner size="small"}}
            {{/if}}
          </div>
          <div class='draft-text'>
            {{i18n 'composer.saved_draft'}}
          </div>
        </div>
      </div>
    {{/if}}

  </div>
</div>
{{/if}}
