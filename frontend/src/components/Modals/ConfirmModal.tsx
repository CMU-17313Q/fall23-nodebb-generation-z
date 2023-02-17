import { Text, Stack, ButtonGroup, Button } from '@chakra-ui/react';
import { useRef } from 'react';
import BaseModal, { BaseModalProps } from './BaseModal';

interface ConfirmModalProps extends BaseModalProps {
    message: string;
    onConfirm: () => void;
    onCancel: () => void;
}

function ConfirmModal({
    title,
    message,
    onConfirm,
    onCancel,
    isOpen,
}: ConfirmModalProps) {
    const buttonRef = useRef<HTMLButtonElement>(null);

    return (
        <BaseModal
            title={title}
            isOpen={isOpen}
            onClose={onCancel}
            initialFocusRef={buttonRef}>
            <Stack spacing={4}>
                <Text>{message}</Text>
                <ButtonGroup>
                    <Button ref={buttonRef} onClick={onConfirm}>
                        Confirm
                    </Button>
                    <Button onClick={onCancel}>Cancel</Button>
                </ButtonGroup>
            </Stack>
        </BaseModal>
    );
}

export default ConfirmModal;
