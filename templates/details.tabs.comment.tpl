<div id="comments" class="tab">
  <?php foreach($comments as $comment): ?>
  <em>
    <a name="comment{$comment['comment_id']}" id="comment{$comment['comment_id']}"
      href="{CreateURL('details', $task_details['task_id'])}#comment{$comment['comment_id']}">
      <img src="{$this->get_image('comment')}"
        title="{L('commentlink')}" alt="" />
    </a>
    {L('commentby')} {!tpl_userlink($comment['user_id'])} -
    {formatDate($comment['date_added'], true)}
  </em>

  <span class="DoNotPrint">
    <?php if ($user->perms('edit_comments') || ($user->perms('edit_own_comments') && $comment['user_id'] == $user->id)): ?>
    &mdash;
    <a href="{$baseurl}?do=editcomment&amp;task_id={Get::num('id')}&amp;id={$comment['comment_id']}">
      {L('edit')}</a>
    <?php endif; ?>

    <?php if ($user->perms('delete_comments')): ?>
    &mdash;
    <a href="{$baseurl}?do=modify&amp;action=details.deletecomment&amp;comment_id={$comment['comment_id']}"
      onclick="return confirm('{L('confirmdeletecomment')}');">
      {L('delete')}</a>
    <?php endif ?>
  </span>
  <div class="comment">
  <?php if(isset($comment_changes[$comment['date_added']])): ?>
  <ul class="comment_changes">
  <?php foreach($comment_changes[$comment['date_added']] as $change): ?>
    <li>{!event_description($change)}</li>
  <?php endforeach; ?>
  </ul>
  <?php endif; ?>
  <div class="commenttext">{!TextFormatter::render($comment['comment_text'], false, 'comm', $comment['comment_id'], $comment['content'])}</div></div>

  <?php if (isset($comment_attachments[$comment['comment_id']])) {
            $this->display('common.attachments.tpl', 'attachments', $comment_attachments[$comment['comment_id']]);
        }
  ?>

  <?php endforeach; ?>

  <?php if ($user->perms('add_comments') && (!$task_details['is_closed'] || $proj->prefs['comment_closed'])): ?>
  <fieldset><legend>{L('addcomment')}</legend>
  <form enctype="multipart/form-data" action="{$baseurl}" method="post">
    <div>
      <?php if (defined('FLYSPRAY_HAS_PREVIEW')): ?>
      <div class="hide preview" id="preview"></div>
      <?php endif; ?>
      <input type="hidden" name="do" value="modify" />
      <input type="hidden" name="action" value="details.addcomment" />
      <input type="hidden" name="task_id" value="{Req::val('task_id', $task_details['task_id'])}" />
      <?php if ($user->perms('create_attachments')): ?>
      <div id="uploadfilebox">
        <span style="display: none;"><?php // this span is shown/copied in javascript when adding files ?>
          <input tabindex="5" class="file" type="file" size="55" name="userfile[]" />
            <a href="javascript://" tabindex="6" onclick="removeUploadField(this);">{L('remove')}</a><br />
        </span>    
      </div>
      <button id="uploadfilebox_attachafile" tabindex="7" type="button" onclick="addUploadFields()">
        {L('uploadafile')} ({L('max')} {$fs->max_file_size} {L('MiB')})
      </button>
      <button id="uploadfilebox_attachanotherfile" tabindex="7" style="display: none" type="button" onclick="addUploadFields()">
         {L('attachanotherfile')} ({L('max')} {$fs->max_file_size} {L('MiB')})
      </button>
      <?php endif; ?>
      {!TextFormatter::textarea('comment_text', 10, 72, array('accesskey' => 'r', 'tabindex' => 8, 'id' => 'comment_text'))}

      <button tabindex="9" type="submit">{L('addcomment')}</button>
      <?php if (defined('FLYSPRAY_HAS_PREVIEW')): ?>
      <button tabindex="9" type="button" onclick="showPreview('comment_text', '{$baseurl}', 'preview')">{L('preview')}</button>
      <?php endif; ?>
      <?php if (!$watched): ?>
      {!tpl_checkbox('notifyme', Req::val('notifyme', !(Req::val('action') == 'details.addcomment')), 'notifyme')} <label class="left" for="notifyme">{L('notifyme')}</label>
      <?php endif; ?>
    </div>
  </form>
  </fieldset>
  <?php endif; ?>
</div>
