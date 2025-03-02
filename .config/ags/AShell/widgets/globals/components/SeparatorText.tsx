import Separator from "./Separator";

interface Props {
  text_before: string;
  text_after: string;
  text_classes?: string[];
  separator_classes?: string[];
}

export default (props: Props) => {
  return (
    <box>
      <label
        cssClasses={props.text_classes ? props.text_classes : [""]}
        label={props.text_before}
      />
      <Separator
        text_classes={props.separator_classes ? props.separator_classes : [""]}
      />
      <label
        cssClasses={props.text_classes ? props.text_classes : [""]}
        label={props.text_after}
      />
    </box>
  );
};
