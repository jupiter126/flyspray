<?php if (!$task['is_closed']): ?>
  <div id="remind" class="tab">

  <form method="post" action="{CreateUrl(array('details', 'task' . $task['task_id']))}#remind" >
    <table id="reminders" class="userlist">
    <tr>
      <th>
        <a href="javascript:ToggleSelected('reminders')">
          <img title="{L('toggleselected')}" alt="{L('toggleselected')}" src="{$this->get_image('kaboodleloop')}" width="16" height="16" />
        </a>
      </th>
      <th>{L('user')}</th>
      <th>{L('startat')}</th>
      <th>{L('frequency')}</th>
      <th>{L('message')}</th>
    </tr>

    <?php foreach ($reminders as $row): ?>
    <tr>
      <td class="ttcolumn">
        <input type="checkbox" name="reminder_id[]" {!tpl_disableif(!$user->can_edit_task($task))} value="{$row['reminder_id']}" />
      </td>
     <td>{!tpl_userlink($row['user_id'])}</td>
     <td>{formatDate($row['start_time'])}</td>
     <?php
      // Work out the unit of time to display
      if ($row['how_often'] < 86400) {
          $how_often = $row['how_often'] / 3600 . ' ' . L('hours');
      } elseif ($row['how_often'] < 604800) {
          $how_often = $row['how_often'] / 86400 . ' ' . L('days');
      } else {
          $how_often = $row['how_often'] / 604800 . ' ' . L('weeks');
      }
     ?>
     <td>{$how_often}</td>
     <td>{!$this->text->render($row['reminder_message'], true)}</td>
  </tr>
    <?php endforeach; ?>
    <tr><td colspan="4">
      <input type="hidden" name="action" value="deletereminder" />
      <input type="hidden" name="task_id" value="{$task['task_id']}" />
      <button type="submit">{L('remove')}</button></td></tr>
    </table>
  </form>

  <fieldset><legend>{L('addreminder')}</legend>
  <form action="{CreateUrl(array('details', 'task' . $task['task_id']))}#remind" method="post" id="formaddreminder">
    <div>
      <input type="hidden" name="action" value="addreminder" />
      <input type="hidden" name="task_id" value="{$task['task_id']}" />

        <label class="default multisel" for="to_user_id">{L('remindthisuser')}</label>
        {!tpl_userselect('to_user_id', Post::val('to_user_id'), 'to_user_id')}
      <br />

      <label for="timeamount1">{L('thisoften')}</label>
      <input class="text" type="text" value="{Post::val('timeamount1')}" id="timeamount1" name="timeamount1" size="3" maxlength="3" />
      <select class="adminlist" name="timetype1">
        {!tpl_options(array(3600 => L('hours'), 86400 => L('days'), 604800 => L('weeks')), Post::val('timetype1'))}
      </select>

      <br />

      {!tpl_datepicker('timeamount2', L('startat'), Post::val('timeamount2'))}

      <br />
      <textarea class="text" name="reminder_message"
        rows="10" cols="72">{Post::val('reminder_message', L('defaultreminder') . "\n\n" . CreateURL(array('details', 'task' . $task['task_id'])))}</textarea>
      <br />
      <button type="submit">{L('addreminder')}</button>
    </div>
  </form>
  </fieldset>
</div>
<?php endif; ?>
