interface Props {
  text_classes?: string[];
}

export default (props: Props) => {
  return (
    <label
      cssClasses={props.text_classes ? props.text_classes : [""]}
      label={" • "}
    />
  );
};
