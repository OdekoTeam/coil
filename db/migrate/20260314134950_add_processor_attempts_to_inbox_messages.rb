# typed: false

class AddProcessorAttemptsToInboxMessages < ActiveRecord::Migration[6.0]
  def change
    comment = <<~DOC.squish
      Number of processor attempts that have been initiated on this message.
    DOC

    add_column(
      :coil_inbox_messages,
      :processor_attempts,
      :integer,
      null: false,
      default: 0,
      comment:
    )
  end
end
